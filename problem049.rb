require "./utility.rb"

=begin
The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330, is unusual in two ways: (i) each of the three terms are prime, 
and, (ii) each of the 4-digit numbers are permutations of one another.

There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting this property, but there is one other 4-digit increasing sequence.

What 12-digit number do you form by concatenating the three terms in this sequence?
=end

primes = (1000..9999).to_a.select{|a| Prime.prime?(a) }
is_prime = []
primes.each{|p| is_prime[p] = true }

prime_groups = {}

primes.each do |p|
  p_key = p.to_s.split("").map(&:to_i).sort.join.to_i
  prime_groups[p_key] ||= []
  prime_groups[p_key] << p
end

prime_groups.select! do |key, numbers|
  numbers.length >= 3
end

breaker = false
prime_groups.sort_by{|a| a[0] }.each do |key, numbers|
  numbers.combination(3).each do |inner_nums|
    inner_nums.sort!
    diff1 = [inner_nums[2] - inner_nums[1], inner_nums[1] - inner_nums[0]]
    diff2 = diff1[1] - diff1[0]
    if diff2 == 0
      ans = inner_nums.join
      if ans != "148748178147"
        puts ans
        breaker = true
        break
      end
    end
  end
  break if breaker
end