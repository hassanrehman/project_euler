require "./utility.rb"

=begin
The prime 41, can be written as the sum of six consecutive primes:

41 = 2 + 3 + 5 + 7 + 11 + 13
This is the longest sum of consecutive primes that adds to a prime below one-hundred.

The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.

Which prime, below one-million, can be written as the sum of the most consecutive primes?
=end


primes = Prime.each(4000).to_a
chains = []
total = primes.count
primes.each_with_index do |p, i|
  #puts "#{i+1} of #{total}"
  if i == 0
    chains << [{l: 1, sum: p}]
    next
  end
  new_chains = [{l: 1, sum: p}] + chains[i-1].map do |chain|
    {l: chain[:l]+1, sum: chain[:sum] + p}
  end
  chains << new_chains
end

chains.flatten!
chains.select!{|c| c[:sum] < 1_000_000 }
chains.select!{|c| Prime.prime?(c[:sum]) }

longest_length = 0
sum = 0
chains.each do |chain|
  if chain[:l] > longest_length
    longest_length = chain[:l]
    sum = chain[:sum]
  end
end

puts sum

