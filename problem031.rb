require "./utility.rb"

=begin
In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:

1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
It is possible to make £2 in the following way:

1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
How many different ways can £2 be made using any number of coins?
=end

class P031

  COINS = [200, 100, 50, 20, 10, 5, 2, 1]

  def initialize
    puts process
  end

  def process
    iterations = 0
    count = 0
    (0..(200/COINS[0])).to_a.each do |i0|
      break if value([i0, 0, 0, 0, 0, 0, 0, 0]) > 200
      (0..(200/COINS[1])).to_a.each do |i1|
        break if value([i0, i1, 0, 0, 0, 0, 0, 0]) > 200
        (0..(200/COINS[2])).to_a.each do |i2|
          break if value([i0, i1, i2, 0, 0, 0, 0, 0]) > 200
          (0..(200/COINS[3])).to_a.each do |i3|
            break if value([i0, i1, i2, i3, 0, 0, 0, 0]) > 200
            (0..(200/COINS[4])).to_a.each do |i4|
              break if value([i0, i1, i2, i3, i4, 0, 0, 0]) > 200
              (0..(200/COINS[5])).to_a.each do |i5|
                break if value([i0, i1, i2, i3, i4, i5, 0, 0]) > 200
                (0..(200/COINS[6])).to_a.each do |i6|
                  iterations+=1 
                  indexes = [i0, i1, i2, i3, i4, i5, i6, 0]
                  sum = value(indexes)
                  break if sum > 200

                  count += 1 if sum <= 200
                end  #i6
              end  #i5
            end  #i4
          end  #i3
        end  #i2
      end  #i1
    end  #i0
    #puts "iterations: #{iterations}"
    puts count
  end

  def value(indexes)
    sum = indexes.each_with_index.map{|v, i| COINS[i]*v }.sum
    return sum
  end

end

P031.new
