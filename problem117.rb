require "./utility.rb"

TOTAL = 50
LENGTHS = {red: 2, green: 3, blue: 4}

class Container

  #array of colors to use
  def initialize(colors)
    puts "with colors: #{colors.inspect}"
    @colors = colors
  end

  def total_tiles_taken(block_counts)
    block_counts.map{|color, count| LENGTHS[color]*count }.sum
  end

  def ways_to_fit(block_counts)
    colored_spaces = total_tiles_taken(block_counts)
    black_tiles = TOTAL - colored_spaces
    return 0 if black_tiles < 0

    total_number_tiles = block_counts.values.sum + black_tiles

    distinct_colors = block_counts.length + (black_tiles == 0 ? 0 : 1)
    puts "total_number_tiles: #{total_number_tiles}, distinct_colors: #{distinct_colors}"
    total_number_tiles.C(distinct_colors - 1)
  end

  def total_ways
    #max of three colors assumed .. so using a tripple loop to cater all possible cases
    complete_total = 0

    (1..TOTAL/(LENGTHS[@colors[0]]||TOTAL)).each do |color_0|
      (1..TOTAL/(LENGTHS[@colors[1]]||TOTAL)).each do |color_1|
        (1..TOTAL/(LENGTHS[@colors[2]]||TOTAL)).each do |color_2|
          block_counts = {}
          block_counts[@colors[0]] = color_0 if @colors[0]
          block_counts[@colors[1]] = color_1 if @colors[1]
          block_counts[@colors[2]] = color_2 if @colors[2]

          total_tiles_taken = total_tiles_taken(block_counts)
          if total_tiles_taken <= TOTAL
            puts [
              ("#{@colors[0]}: #{color_0}" if @colors[0]), 
              ("#{@colors[1]}: #{color_1}" if @colors[1]), 
              ("#{@colors[2]}: #{color_2}" if @colors[2]), 
              "space: #{total_tiles_taken}",
              "ways to fit: #{ways_to_fit(block_counts)}"].compact.join(", ")
          end

          if total_tiles_taken <= TOTAL
            complete_total += ways_to_fit(block_counts)
          end


        end
      end
    end
    return complete_total


  end

end

c = [:red, :green, :blue]

puts [
  *c.map{|a| Container.new([a]) },   #one color at a time
  *c.combination(2).to_a.map{|a| Container.new(a) },  #two colors at a time
  Container.new(c)  #all colors
].map(&:total_ways).sum + 1    #+1 if for all black

