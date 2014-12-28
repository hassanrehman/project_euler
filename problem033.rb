require "./utility.rb"

=begin
The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it 
may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.

We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

There are exactly four non-trivial examples of this type of fraction, less than one in value, 
and containing two digits in the numerator and denominator.

If the product of these four fractions is given in its lowest common terms, find the value of the denominator.
=end

class P033
  def initialize
    puts process
  end

  def process
    fractions = []
    (11..99).to_a.reject{|a| a%10 == 0 }.each do |num|
      ((num+1)..99).to_a.reject{|a| a%10 == 0 }.each do |den|
        if is_curious(num, den)
          fractions << Rational(num, den)
        end
      end
    end
    return fractions.multiply
  end

  def is_curious(num, den)
    num_array = num.to_s.split("").map(&:to_i)
    den_array = den.to_s.split("").map(&:to_i)

    common = (num_array & den_array)[0]
    return false if common.nil?

    new_num = num_array[0] == common ? num_array[1] : num_array[0]
    new_den = den_array[0] == common ? den_array[1] : den_array[0]

    return Rational(new_num, new_den) == Rational(num, den)

  end



end

P033.new