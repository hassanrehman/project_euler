

def get_result(d)
  max = (d*3 / 7.0).ceil    #nearest to be greater than 3/7 value

  n = max - 1
  loop do
    #if n / d < 3 / 7 .. then n is the answer
    return n if n*7 < d*3
    n -= 1

  end

end

denominator = 2
numerator = get_result(denominator)

(3..1_000_000).each do |d|
  new_denominator = d
  new_numerator = get_result(d)

  #if new > old .. replace
  if new_numerator * denominator > numerator * new_denominator
    numerator = new_numerator
    denominator = new_denominator
  end

end

puts "#{numerator}/#{denominator}"

