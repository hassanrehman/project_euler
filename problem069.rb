require "./utility"

=begin
Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of numbers less than n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6.

n Relatively Prime  φ(n)  n/φ(n)
2   1                 1     2
3   1,2               2     1.5
4   1,3               2     2
5   1,2,3,4           4     1.25
6   1,5               2     3
7   1,2,3,4,5,6       6     1.1666...
8   1,3,5,7           4     2
9   1,2,4,5,7,8       6     1.5
10  1,3,7,9           4     2.5
It can be seen that n=6 produces a maximum n/φ(n) for n ≤ 10.

Find the value of n ≤ 1,000,000 for which n/φ(n) is a maximum.
=end

class P069
  LIMIT = 6_00_000
  PRIMES_LIMIT = 1_000
  def initialize
    #brute_force
    process
  end

  def primes
    @_primes ||= Prime.each(PRIMES_LIMIT).to_a
  end
  def max_prime
    @_max_prime ||= primes[-1]
  end

  def check_prime_divisors_method
    (2..1_000_00).each do |n|
      method_1 = primes_divisors(n).join(",")
      method_2 = Prime.prime_division(n).map(&:first).join(",")
      raise "\nn: #{n}\n#{method_1.inspect}\n#{method_2.inspect}\n\n" if method_1 != method_2
    end
  end

  def is_prime(n)
    @_is_prime ||= primes.inject({}){|s, p| s.merge!(p => true) }
    n > max_prime ? Prime.miller_rabin_prime?(n) : @_is_prime[n]
  end

  def primes_divisors(n)
    #return Prime.prime_division(n).map(&:first)
    #return [n] if is_prime(n)
    to_return = []
    sqrt_n = Math.sqrt(n)
    primes.each do |p|
      break if p > sqrt_n + 2
      if n%p == 0
        to_return << p
        loop do
          n /= p
          return to_return if n == 1
          break if n%p != 0
        end
      end
    end
    #if all primes are exhausted .. that means the ending number is a prime itself
    to_return << n
    return to_return
  end

  def n_by_phi(n)
    t = Time.now
    ps = primes_divisors(n)
    ps.multiply.to_f / ps.map{|p| p - 1 }.multiply.to_f
  end

  def brute_force
    max = 0
    max_n = 0
    (2..LIMIT).each do |n|
      if (nbyphi = n_by_phi(n)) > max
        max = nbyphi
        max_n = n
        puts "n: #{max_n}, n/phi: #{max}: (divisors: #{primes_divisors(n).inspect})"
      end
    end
  end

  #was using brute force before .. but takes too long
  #what i realized in brute force though is that because:
  # n by phy = product(prime_factor) / product(prime_factor-1)
  # this value will be max when there are many numbers there 
  # (the size of the numbers matters less)

  #my theory is also proven by the brute force method which spits out the
  #running maximum n_by_phy in this order:
  # n: 2, n/phi: 2.0: (divisors: [2])
  # n: 6, n/phi: 3.0: (divisors: [2, 3])
  # n: 30, n/phi: 3.75: (divisors: [2, 3, 5])
  # n: 210, n/phi: 4.375: (divisors: [2, 3, 5, 7])
  # n: 2310, n/phi: 4.8125: (divisors: [2, 3, 5, 7, 11])
  # n: 30030, n/phi: 5.213541666666667: (divisors: [2, 3, 5, 7, 11, 13])
  # n: 510510, n/phi: 5.539388020833333: (divisors: [2, 3, 5, 7, 11, 13, 17])

  #hence we need to keep multiplying prime numbers till the result exceeds the limit
  def process
    limit = 1_000_000
    ans = 1
    Prime.each do |p|
      break if (t = ans*p) > limit
      ans = t
    end
    puts ans
  end
end

P069.new