require "./utility"

=begin
The first two consecutive numbers to have two distinct prime factors are:

14 = 2 × 7
15 = 3 × 5

The first three consecutive numbers to have three distinct prime factors are:

644 = 2² × 7 × 23
645 = 3 × 5 × 43
646 = 2 × 17 × 19.

Find the first four consecutive integers to have four distinct prime factors. What is the first of these numbers?
=end

#checks if number has n prime factors
### used this to get the correct ans .. runs in like 2s .. then used info from here
#to generate primes in 200_000 for optimimum performance
def has_3_pfs_bk(number)
  Prime.prime_division(number, Prime::TrialDivisionGenerator.new).length == 3
end

def primes
  @primes ||= Prime.each(200_000).to_a
end

def is_prime?(n)
  @is_prime ||= [].tap{ |a| primes.each{|p| a[p] = true } }
  @is_prime[n]
end

def has_3_pfs(number)
  ans = 0
  #puts "n: #{number}"
  return false if is_prime?(number)  #means ans == 1
  primes.each do |p|
    #puts "searching with: #{p}"
    if number % p == 0
      ans += 1
      loop do
        number /= p
        break if number % p != 0
      end
      #puts "after one it: #{number}"
      break if number == 1
      if is_prime?(number)
        ans += 1
        break
      end
    end
  end
  return ans == 4
end



num = 2*3*5*7  #first num to have 4 prime factors
consecutive = 0
ans = 0

loop do
  if has_3_pfs(num)
    ans = num if consecutive == 0
    consecutive += 1
  else
    consecutive = 0
  end

  break if consecutive == 4

  num += 1
end

puts ans