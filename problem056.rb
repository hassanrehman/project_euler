require "./utility.rb"

=begin
A googol (10100) is a massive number: one followed by one-hundred zeros; 100100 is almost unimaginably large: one followed by two-hundred zeros. Despite their size, the sum of the digits in each number is only 1.

Considering natural numbers of the form, ab, where a, b < 100, what is the maximum digital sum?
=end

def sum_of_digits(a, b)
  (a**b).to_s.split("").map(&:to_i).sum
end

max = 0
(1..99).each do |a|
  (1..99).each do |b|
    if (s = sum_of_digits(a, b)) > max
      max = s
    end
  end
end

puts max