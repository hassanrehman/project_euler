
=begin
In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, 
by only moving to the right and down, is indicated in bold red and is equal to 2427.

Find the minimal path sum, in matrix.txt (right click and "Save Link/Target As..."), 
a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right by only moving right and down.
=end
#https://projecteuler.net/project/resources/p081_matrix.txt

class P081
  def initialize
    process
  end

  def grid
    return @_grid ||= File.read("./files/P081.txt").split("\n").map(&:strip).map{|l| l.split(",").map(&:strip).map(&:to_i) }

    #test grid
    @_grid ||= [
      [131, 673, 234, 103,  18],
      [201,  96, 342, 965, 150],
      [630, 803, 746, 422, 111],
      [537, 699, 497, 121, 956],
      [805, 732, 524,  37, 331]
    ]
  end

  def process
    l = grid.length
    new_grid = []
    l.times{ new_grid << [0]*l }
    new_grid[0][0] = grid[0][0]

    grid.each_with_index do |r, i|
      r.each_with_index do |c, j|
        #forward
        if new_grid[i][j+1]  #workable (non-null)
          new_value = new_grid[i][j] + grid[i][j+1]
          #if empty (0) or smaller than existing
          if (new_grid[i][j+1] == 0) or (new_grid[i][j+1] > 0 and new_grid[i][j+1] > new_value)
            new_grid[i][j+1] = new_value
          end
        end

        #downward
        if (new_grid[i+1]||[])[j]
          new_value = new_grid[i][j] + grid[i+1][j]
          if (new_grid[i+1][j] == 0) or (new_grid[i+1][j] > 0 and new_grid[i+1][j] > new_value)
            new_grid[i+1][j] = new_value
          end
        end
      end
    end
    #print_grid(new_grid)
    puts new_grid[l-1][l-1]

  end

  def print_grid(g)
    g.each do |r|
      puts r.inspect
    end
  end

end

P081.new
