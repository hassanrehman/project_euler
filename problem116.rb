require "./utility.rb"

TOTAL = 50
RED = 2
GREEN = 3
BLUE = 4

class Block
  def initialize(block_length)
    @block_length = block_length
    @total_length = TOTAL
  end

  def ways_to_fit(number_of_blocks)
    black_tiles = @total_length - number_of_blocks*@block_length
    total_tiles = black_tiles + number_of_blocks
    total_tiles.C(number_of_blocks)
  end

  def total_ways
    (1..(@total_length/@block_length)).map do |no_of_blocks|
      #puts "ways to fit: #{no_of_blocks} of length #{@block_length} are: #{ways_to_fit(no_of_blocks)}"
      ways_to_fit(no_of_blocks)
    end.sum
  end

end

puts [RED, BLUE, GREEN].map{|c| Block.new(c).total_ways }.sum