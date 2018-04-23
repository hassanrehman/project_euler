require 'prime'
primes = Prime.each(100).to_a


#for every new prime introduced .. the number of summations is
#the breakdown of two previously already calculated smaller denominations (i)
target = 2
loop do
  ways = [1] + [0]*target
  for i in primes
    for j in i..target
      ways[j] += ways[j-i]
	    # puts "i: #{i}, j: #{j} - #{ways.inspect}"
	  end
  end

  
  break if ways[target] > 5000
  target += 1
end

puts target