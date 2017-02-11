require 'set'

class Array
  def to_i
    l = self.length
    self.each_with_index.map do |d, i|
      d * (10**(l - i - 1))
    end.inject(&:+)
  end
end

class Fixnum
  class << self
    attr_accessor :_factorials, :_to_a, :_next
  end
  
  def !
    @_factorials ||= []
    return @_factorials[self] if @_factorials[self]
    result = (self == 0 or self == 1) ? 1 : (2..self).to_a.inject(&:*)
    @_factorials[self] = result
  end

  def next
    @@_next ||= []
    return @@_next[self] if @@_next[self]

    sum = 0
    n = self
    while n > 0 do 
      r = n % 10
      sum += r.!
      n /= 10
    end

    @@_next[self] = sum    

  end

end

class Problem074

  def initialize
    @chains = []
    process
  end

  def process
    s = Time.now
    count = 0
    (1..1000_000).each do |n|

      if n % 100_000 == 0
        puts "#{n} in #{(Time.now - s).round(2)}s"
      end
      l = chain_mem(n)
      if l == 60
        count += 1
        # puts "l: #{l}, n: #{n} ( next: #{n.next} ) - count: #{count}"
      end
    end
    puts count
  end

  #only to check
  def chain(n)
    c = {n => true}
    v = [n]
    loop do 
      n = n.next
      v << n
      if c[n]
        # puts "chain: #{v.inspect}"
        return c.length
      else
        c[n] = true
      end
    end
  end

  def add_to_chain(n, ch, permutation_value=nil)
    @chains[n] = ch
    # permutation_value ||= ch
    # if n > 10 and n < 1000_000
    #   #try uniq 
    #   # n.to_a.permutation.to_a
    #   # .permutation.each do |i|
    #   #   next if i[0] == 0
    #   #   @chains[i.to_i] ||= permutation_value
    #   # end
    # end
  end

  # n = [100, 3, 6, 720, 5043, 151, 122, 5, 120, 4, 24, 26, 722, 5044, 169, 363601, 1454, 169]
  # i =   0   1  2   3     4    5    6   7   8   9  10  11   12   13    14     15    16    14     17 
  # c    17  16  15  14    13   12   11  10   9  8   7   6   5     4     3     3      3    
  # 100 => 17

  def chain_mem(n)
    return @chains[n] if @chains[n]
    @ran_for ||= 0
    @ran_for += 1
    # puts "RUNNING FOR: #{n}"
    first_n = n
    i = 0
    c = {n => i}
    loop do 
      i += 1
      n = n.next
      #if found in private loop .. look for repeating chain and assign
      if c[n]
        # puts "chain_mem: found end of chain on #{n}"
        repeated_at = c[n]
        max_index = i
        c.each do |number, index|
          if index < repeated_at
            add_to_chain(number, max_index - index)
          else
            #when the number is one of the permutations of one of the numbers in the cycle .. they'd be > 1 in the cycle
            add_to_chain(number, max_index - repeated_at)
          end
        end
        return c.length
      elsif max_chain = @chains[n]
        # puts "chain_mem: reusing #{n} which is #{max_chain}"
        #if found on the outer chain ..  assign to each in this chain
        max_index = i
        c.each do |number, index|
          add_to_chain(number, ( max_chain + ( max_index - index ) ) )
        end
        return @chains[first_n]
      else
        c[n] = i
      end
    end
  end

end

Problem074.new










