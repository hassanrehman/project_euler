require "./utility.rb"

=begin
It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.
=end

class P052
  def initialize
    process
  end

  def process
    n = 2
    loop do 
      nums = [n*2, n*3, n*4, n*5, n*6]

      #assuming in the requirements that: 1 number can only come once .. 
      if nums.any? do |n|
          t = n.to_s.split("")
          t.length != t.uniq.length
        end
        n += 1
        next
      end

      if nums[-1].to_s.length > n.to_s.length
        n = 10**n.to_s.length
        next
      end
      #puts "#{n} -> #{nums.inspect}"

      num_strs = nums.map(&:to_s)
      if num_strs.map(&:length).uniq.length == 1
        if num_strs.map{|a| a.split("").map(&:to_i).sort.join }.uniq.length == 1
          puts n
          break
        end
      end

      n += 1
    end
  end



end

P052.new