primes = [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79]

target = 2
loop do
  ways = [1] + [0]*target
  for i in primes
	#puts i
    for j in i..target
      ways[j] += ways[j-i]
	  #puts ways.inspect
	end
  end
  
  break if ways[target] > 5000
  target += 1
end

puts "Answer to PE77 = #{target}"