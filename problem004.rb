require './utility.rb'

#A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
#Find the largest palindrome made from the product of two 3-digit numbers.

def is_pal(n)
  n = n.to_s
  n == n.reverse
end

largest = 0
(100..999).each do |n1|
  (100..999).each do |n2|
    if is_pal(val = n1*n2)
      largest = val if val > largest
    end
  end
end

puts largest
