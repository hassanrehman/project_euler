class Collatz

  def initialize
    #determines the chain lengths of numbers against numbers
    @chain_lengths = {1 => 1, 2 => 2}
  end

  def chain_lengths
    puts @chain_lengths.inspect
  end

  def collatz(n)
    (n%2 == 0) ? n/2 : 3*n + 1
  end

  def chain_length(start)
    chain = [start]
    iterations = 0
    pre_chain_length = 0
    loop do
      iterations += 1
      n = collatz(chain[-1])
      #will never break at 1 or 2 because of the default inclusions
      if (pre_chain_length = @chain_lengths[n])
        break
      else
        chain << n
      end
    end
    #puts iterations
    #add all numbers with their chain numbers to the hash
    chain.each_with_index do |c, i|
      @chain_lengths[c] ||= chain.length - i + pre_chain_length
    end
    # puts chain.inspect
    # puts chain.length
    # puts pre_chain_length
    return chain.length + pre_chain_length
  end

  def longest_chain_length(starting_bound = 1_000_000)
    longest = 0
    starting_num = 0
    (13..starting_bound).each do |i|
      l = chain_length(i)
      if l > longest
        longest = l
        starting_num = i
      end
    end
    return starting_num
  end

end

c = Collatz.new
puts c.longest_chain_length
