require "./utility.rb"

class Spiral

  def initialize
    @s = [
      [1, 3],
      [1, 9],
      [1, 7],
      [1, 5]
    ]
    @grid_size = 1001
    
    (0..3).each do |i|
      (((@grid_size+1)/2) - 2).times do 
        @s[i] << (@s[i][-1] - @s[i][-2] + 8 + @s[i][-1])
      end
    end

    #make sure to count '1' just once
    puts @s.map{|a| a.sum }.sum - 3

  end


end

Spiral.new