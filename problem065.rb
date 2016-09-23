
c = 100

e = [2, *(1..(c/3 + 1)).to_a.flat_map{|a| [1, 2*a, 1] }].first(c)

r = nil
e.reverse.each_with_index do |n, i|
  r = (i == 0 ? n : n + Rational(1, r))
end

puts r.numerator.to_s.split("").map(&:to_i).inject(&:+)

