require 'bigdecimal'


def literally(a, n)
  v = (a + 1) ** n + (a - 1) ** n
  v % (a*a)
end

def nck(n, k)
  return 1 if k == 0
  return n if k == 1

  (0...k).inject(1) do |result, l|
    result *= Rational(n - l, k - l)
  end.to_i
end

def my_method(a, n)
  result = 0
  a2 = a*a
  0.step(n, 2) do |k|
    result += 2 * nck(n, k) * ( a ** ( n - k ) )
    result %= (a2)
    result
  end
  result
end

t = Time.now
elapsed = lambda{ "#{(Time.now - t).round(2)}s" }
result = 0
(3..1000).each do |a|
  puts "#{elapsed.call} - a = #{a}"
  max_remainder = 0
  (1...a).each do |n|
    # mine = my_method(a, n)
    v = literally(a, n)
    max_remainder = v if max_remainder < v
    # raise "a: #{a}, n: #{n} -- #{literal} != #{mine}" if mine != literal
  end
  result += max_remainder
end
puts result


# Test nck
# def factorial(a)
#   a == 0 ? 1 : (1..a).inject(&:*)
# end
# def nck_literal(n, k)
#   factorial(n) / ( factorial(k) * factorial(n-k) )
# end
# t = Time.now
# (5..500).each do |n|
#   puts "#{Time.now} - n: #{n}"
#   (0...n).each do |k|
#     literal = nck_literal(n, k)
#     mine = nck(n, k)
#     raise "n: #{n}, k: #{k} -- #{literal} != #{mine}" if mine != literal
#   end
# end
# puts "took: #{(Time.now - t).round(2)}s"




