require 'prime'

class Amicable

  def initialize
    @numbers = (2..1_000_000).to_a
    @numbers_used = Array.new(1000000, false)
    @numbers_used[0] = true
    @numbers_used[1] = true
    @chains = []
  end

  def sum_of_divisors(n)
    Prime.prime_division(n).map{|p, a| (p**(a+1) - 1)/(p - 1) }.inject(&:*) - n
  end

  def find_chain(n)
    chain = [n]
    loop do
      member = sum_of_divisors(chain[-1])
      if chain.include?(member)
        chain << member
        @numbers_used << member
        return true, chain
      elsif member == 1 or member >= 1000000 or @numbers_used[member]
        return false, chain
      else
        chain << member
        @numbers_used[member] = true
      end
    end
  end

  def result_so_far
    actual_chains = @chains.map do |c|
      i = c.index(c[-1])
      c[i..-2]
    end
    longest_chain = actual_chains.sort{|a, b| b.length <=> a.length }[0]
    puts "LONGEST CHAIN SO FAR: #{longest_chain.inspect}, ans: #{longest_chain.min}"
  end

  def process
    s = Time.now
    time_printed = []
    @numbers.each do |n|
      next if @numbers_used[n]
      is_amicable, chain = find_chain(n)

      if is_amicable
        @chains << chain
        puts "#{n}: #{chain.inspect}"
      end
      @numbers_used[n] = true

      t = (Time.now - s).to_i
      if t > 0 and t%10 == 0 and !time_printed.include?(t)
        puts "n: #{n}, t: #{t}s"
        time_printed << t
        result_so_far
      end
    end
  end

end
Amicable.new.process