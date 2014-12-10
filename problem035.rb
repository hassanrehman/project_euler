require './utility.rb'


#The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.
#There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
#How many circular primes are there below one million?

@all_primes = Prime.each(10**6).to_a
@is_prime = Array.new(10**6, false)
@all_primes.each do |p|
  @is_prime[p] = true
end

def is_circular(p)
  digits = p.to_s.split("").map(&:to_i)
  digits = digits.length.times.map{ digits = digits.rotate  }.map{|a| a.map(&:to_i).join.to_i }
  
  digits.all?{|a| @is_prime[a] }

end

total = @all_primes.count
count = 0
@all_primes.each_with_index do |p, i|
  count += 1 if is_circular(p)

  puts "#{i} of #{total}" if i%1000 == 0
end

puts "ans: #{count}"