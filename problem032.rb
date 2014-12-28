require "./utility.rb"

=begin
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; 
for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.
=end

class P032
  def initialize
    puts process
  end

  def process
    n1 = 1
    big_breaker = false
    nums = []
    loop do
      n2 = n1 + 1
      loop do 
        p = n1*n2
        s = "#{n1}#{n2}#{p}"
        if s.length < 9
          n2 += 1
          next
        end
        if s.length > 9
          big_breaker = (n2 == n1 + 1)
          break
        end
        if is_pandigital(n1, n2, p)
          #puts "#{n1}x#{n2}=#{p}"
          nums << p
        end
        n2 += 1
      end
      n1 += 1
      break if big_breaker
    end
    return nums.uniq.sum
  end

  #TODO: there are MUCH faster ways to find this out
  def is_pandigital(n1, n2, p)
    "#{n1}#{n2}#{p}".split("").sort.join == "123456789"
  end

end

P032.new