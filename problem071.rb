

def limit
  @@_limit ||= (3 / 7.0)
end

def limit_fraction
  @@_limit_fraction ||= Rational(3, 7)
end

def get_range(d)
  min = d/3
  max = d/2

  tolerance = 1   #how much to loop downwards

  iterations = 1
  loop do 

    mid = (min + max) / 2
    r = mid / d.to_f 

    if r > limit
      max = mid
    else r < limit
      min = mid
    end

    break if max - min <= tolerance

    iterations += 1

  end

  # puts "d: #{d}, iterations: #{iterations}"
  return min, max
end

def get_result(d)
  min, max = get_range(d)

  #with tolerance = 1 .. there would be only one of these two candidates to be less than 3/7

  #if max / d < 3 / 7 then max .. etc
  return max if max * 7 < 3 * d
  return min if min * 7 < 3 * d
  return min - 1

end

denominator = 2
numerator = get_result(denominator)

(3..1_000_000).each do |d|
  if d % 10_000 == 0
    puts d
  end

  new_denominator = d
  new_numerator = get_result(d)

  #if new > old .. replace
  if new_numerator * denominator > numerator * new_denominator
    numerator = new_numerator
    denominator = new_denominator
  end

end

puts "#{numerator}/#{denominator}"

