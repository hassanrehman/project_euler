

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
  n = max

  iterations = 1
  loop do  

    curr = Rational(n, d)
    prev = Rational(n-1, d)

    break if curr > limit_fraction and prev < limit_fraction

    break if n <= min  #sanity
    n -= 1
    iterations += 1
    # puts "d: #{d}, diff: #{max - min}, iterations: #{iterations}"
  end

  return (n - 1)
end

curr = Rational(get_result(2), 2)
(3..1_000_000).each do |d|
  if d % 10_000 == 0
    puts d
  end
  r = Rational(get_result(d), d)
  if r > curr
    curr = r
  end
end

puts curr

