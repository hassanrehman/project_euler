start_time= Time.now
MAX_BASE = 5000
MAX = 10**8
palins = []
1.upto(MAX_BASE) do |i|
  sum = i*i
  (i+1).upto(MAX_BASE) do |j|
    sum += j*j
	break if sum > MAX
	s = sum.to_s
	palins << sum if s == s.reverse and !palins.include?(sum)
  end
end
puts palins.reduce(:+)
puts "#{Time.now - start_time} seconds.."

