require './utility.rb'

MAX = 12_000

SEARCH_MIN = 1/3.to_f
SEARCH_MAX = 1/2.to_f

t = Time.now
r = 0
(2..MAX).each do |d|
  # puts "d: #{d} -- #{t.elapsed}s" if d%1_000 == 0

  ( (d/3)...d ).each do |n|
    rd = n/d.to_f
    next if rd < SEARCH_MIN
    break if rd > SEARCH_MAX

    if d.gcd(n) == 1
      #if n/d > 1/3 and n/d < 1/2
      if 3*n > d and 2*n < d
        r += 1
      end

    end

  end

end

puts r
puts "#{t.elapsed}s"