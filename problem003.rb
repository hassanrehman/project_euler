require './utility.rb'
require 'prime'

n = 600851475143
largest_prime = 2
Prime.each(Math.sqrt(n) + 10) do |p|
  largest_prime = p if n%p == 0 and p > largest_prime
end

puts largest_prime