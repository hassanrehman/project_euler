require './utility.rb'

#2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
#What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

factors = {}
(2..20).to_a.each do |a|
  Prime.prime_division(a).each do |n, power|
    factors[n] ||= 1
    factors[n] = [power, factors[n]].max
  end
end
puts factors.map{|n, p| n**p }.multiply