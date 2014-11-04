require "./utility.rb"

#145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
#Find the sum of all numbers which are equal to the sum of the factorial of their digits.
#Note: as 1! = 1 and 2! = 2 are not sums they are not included.

def is_curious(n)
  n.to_s.split("").map(&:to_i).map(&:factorial).sum == n
end

curious_nums = []
(3..100000).each do |i|
  if is_curious(i)
    curious_nums << i
    puts "#{curious_nums.inspect} -> #{curious_nums.sum}"
  end
end