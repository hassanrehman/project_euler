require "./utility"

=begin
It is possible to show that the square root of two can be expressed as an infinite continued fraction.

√ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...

By expanding this for the first four iterations, we get:

1 + 1/2 = 3/2 = 1.5
1 + 1/(2 + 1/2) = 7/5 = 1.4
1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...

The next three expansions are 99/70, 239/169, and 577/408, but the eighth expansion, 1393/985, is the first example where the number of digits in the numerator exceeds the number of digits in the denominator.

In the first one-thousand expansions, how many fractions contain a numerator with more digits than denominator?
=end

#sagi .. do it like this:
#1000.times{ prev_result = 1 + Rational(1, 1+prev_result) }

def digit_count(n)
  n.to_s.length
end

prev_result = 1

count = 0
1000.times do 
  result = 1 + Rational(1, 1+prev_result)
  count += 1 if digit_count(result.numerator) > digit_count(result.denominator)

  prev_result = result
end

puts count