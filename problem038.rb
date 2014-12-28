require "./utility.rb"

=begin
Take the number 192 and multiply it by each of 1, 2, and 3:

192 × 1 = 192
192 × 2 = 384
192 × 3 = 576
By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, 
which is the concatenated product of 9 and (1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1?
=end

class P038
  def initialize
    process
  end

  def process
    max = 0
    #these were incremental .. if needed more ranges in powers of 10 starting with 9 cud be added
    [9, *(91..99).to_a, *(900..999).to_a, *(9_000..9_999).to_a, *(90_000..99_999).to_a].each do |n|
      if (p = pan(n))
        if p > max
          max = p
        end
      end
    end
    puts max
  end

  def pan(n)
    s = ""
    i = 1
    loop do
      s = "#{s}#{i*n}"
      break if s.length >= 9
      i += 1
    end

    return nil if s.length > 9
    if s.split("").sort.join == "123456789"
      return s.to_i
    end
    return nil
  end

end

P038.new