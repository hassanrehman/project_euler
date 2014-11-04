require 'prime'
require "./utility.rb"


def sum_of_divisors(n)
  Prime.prime_division(n).map{|p, a| (p**(a+1) - 1)/(p - 1) }.inject(&:*) - n
end

class Abundant
  def initialize
    @abundants = (12..28124).select{|a| is_abundant(a) }

    numbers = (0..28125).to_a
    @abundants.each do |i|
      @abundants.each do |j|
        if (k = (i+j)) <= 28125
          numbers[k] = 0
        else
          break
        end
      end
    end

    puts numbers.sum

  end

  def is_abundant(n)
    sum_of_divisors(n) > n
  end

end

Abundant.new
