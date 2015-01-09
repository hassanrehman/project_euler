require "./utility.rb"

=begin
Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.

*37  36  35  34  33  32 *31
 38 *17  16  15  14 *13  30
 39  18  *5   4  *3  12  29
 40  19   6   1   2  11  28
 41  20  *7   8   9  10  27
 42  21  22  23  24  25  26
*43  44  45  46  47  48  49

It is interesting to note that the odd squares lie along the bottom right diagonal, 
but what is more interesting is that 8 out of the 13 numbers lying along both diagonals are prime; 
that is, a ratio of 8/13 ≈ 62%.

If one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed. 
If this process is continued, what is the side length of the square spiral for which the ratio of primes along 
both diagonals first falls below 10%?
=end


class P058
  def initialize
    @diagonals = [
      [1, 3],
      [1, 5],
      [1, 9],
      [1, 7]
    ]
    @number_count = 5
    @prime_count = 3
    @side_length = 3
    @ratio = @prime_count.to_f * 100 / @number_count.to_f

    process
  end

  def is_prime?(n)
    return Prime.miller_rabin_prime?(n)  #<2s so far .. certain
    #return Prime.fermat_prime?(n)  #<2s  not certain .. little problems found so far
    #return Prime.prime?(n, Prime::TrialDivisionGenerator.new)  #<9s
    #return Prime.prime?(n)  #<23s
  end

  def iterate
    @diagonals.each_with_index do |diagonal, i|
      new_num = (diagonal[-1] - diagonal[-2]) + 8 + diagonal[-1]
      @diagonals[i] << new_num
      @diagonals[i].delete_at(0)
      if is_prime?(new_num)
        @prime_count += 1
      end
    end
    @number_count += 4
    @side_length += 2
    @ratio = @prime_count.to_f * 100 / @number_count.to_f
  end

  def process
    loop do
      iterate
      #puts "#{@side_length} : #{@ratio}"
      if @ratio < 10.0
        puts @side_length
        break
      end
    end
  end

end

P058.new

#should be 26241
#coming as 26609