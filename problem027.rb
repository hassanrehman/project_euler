require "./utility.rb"

#Euler discovered the remarkable quadratic formula:
#n² + n + 41
#It turns out that the formula will produce 40 primes for the consecutive values n = 0 to 39. 
#However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly divisible by 41.

#The incredible formula  n² − 79n + 1601 was discovered, which produces 80 primes for the consecutive values n = 0 to 79. The product of the coefficients, −79 and 1601, is −126479.
#Considering quadratics of the form:

#n² + an + b, where |a| < 1000 and |b| < 1000
#where |n| is the modulus/absolute value of n
#e.g. |11| = 11 and |−4| = 4
#Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number 
#  of primes for consecutive values of n, starting with n = 0.

def gen_primes(a, b)
  n = 0
  primes = []
  loop do 
    q = n*n + a*n + b
    if Prime.prime?(q)
      primes << q
    else
      break
    end
    n += 1
  end
  return primes
end

as = Prime.each(999).to_a
as = [*as, *as.map{|i| -i }]
bs = (-999..999).to_a

max_primes = 0
ans = 0
as.product(bs).each do |a, b|
  primes = gen_primes(a, b)
  if primes.count > max_primes
    #puts "(#{a}, #{b}) -> #{primes.join(", ")} (#{primes.count})}"
    max_primes = primes.count
    ans = a*b
  end
end

puts ans