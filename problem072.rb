require './utility.rb'

MAX = 10**6
MAX_PRIMES = MAX    #this can be reduced .. but then prime factorization will have to determine if the number is prime

# MAX_PRIMES = Math.sqrt(MAX).to_i + 2

t = Time.now
$primes = Prime.each(MAX_PRIMES).to_a
$is_prime = Array.new(MAX_PRIMES)
$primes.each{|p| $is_prime[p] = true }
puts "prime generation took: #{t.elapsed}s"

class Fixnum
  def prime_divisors
    n = self
    return [n] if $is_prime[n]

    r = []
    i = 0
    while ( n > 1 ) do 
      if $is_prime[n]
        if r.length == 0 or (r.length > 0 and r[-1] != n)
          r << n
        end
        break
      end
      d = $primes[i]
      if n%d == 0
        n /= d
        if r.length == 0 or (r.length > 0 and r[-1] != d)
          r << d
        end
      else 
        i += 1
      end
    end
    return r

  end

  def phi
    n = self
    ps = prime_divisors
    (n*ps.map{|a|a-1}.inject(&:*)) / ps.inject(&:*)
  end
end

count = 0
(2..MAX).each do |i|
  if i % 10_000 == 0
    puts i
  end
  count += i.phi
end
puts count

