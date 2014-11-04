require "./utility.rb"

#The decimal number, 585 = 1001001001 (binary), is palindromic in both bases.
#Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.
#(Please note that the palindromic number, in either base, may not include leading zeros.)

def is_palindrome(n)
  n = n.to_s.strip
  n == n.reverse
end

puts (0..(10**6)).to_a.select{|a| is_palindrome(a) and is_palindrome(a.to_s(2)) }.sum
