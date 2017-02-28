
# https://en.wikipedia.org/wiki/Methods_of_computing_square_roots
# https://www.easycalculation.com/learn-square-root-long-division.php

class Fixnum
  def run
    n = self
    digits = []

    sq = Math.sqrt(n).to_i
    digits << sq
    remainder = n - sq*sq
    return 0 if remainder == 0

    105.times do |i|
      quo = digits.join.to_i * 20

      remainder *= 100

      factor = 0
      loop do
        break if (quo + factor) * factor > remainder
        factor += 1
      end

      factor -= 1
      digits << factor
      remainder -= (quo + factor) * factor
    end

    return digits[0...100].inject(&:+)
  end
end

puts (1..100).map(&:run).inject(&:+)

