require "./utility.rb"

=begin
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

d2d3d4=406 is divisible by 2
d3d4d5=063 is divisible by 3
d4d5d6=635 is divisible by 5
d5d6d7=357 is divisible by 7
d6d7d8=572 is divisible by 11
d7d8d9=728 is divisible by 13
d8d9d10=289 is divisible by 17
Find the sum of all 0 to 9 pandigital numbers with this property.
=end

#much faster than a.join.to_i
def get_num(a)
  100*a[0] + 10*a[1] + a[2]
end

sum = 0
(0..9).to_a.permutation.each do |perm|
  next if perm[0] == 0
  next unless get_num(perm[7..9]) % 17 == 0
  next unless get_num(perm[6..8]) % 13 == 0
  next unless get_num(perm[5..7]) % 11 == 0
  next unless get_num(perm[4..6]) % 7 == 0
  next unless get_num(perm[3..5]) % 5 == 0
  next unless get_num(perm[2..4]) % 3 == 0
  next unless get_num(perm[1..3]) % 2 == 0
  sum += perm.join.to_i
end

puts sum