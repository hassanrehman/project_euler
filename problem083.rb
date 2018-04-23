class Q
  def initialize; @queue = []; end
  def q(o)
    (o = [o]) unless o.is_a?(Array)
    @queue += o
  end
  def dq; @queue.shift(1)[0]; end
  def peek; @queue[0]; end
  def to_s
    @queue.map{|p1, p2| "#{p1}->#{p2}" }.inspect
  end
  def inspect; to_s; end
  def length; @queue.length; end
end

class P
  attr_reader :i, :j
  def initialize(i, j); @i = i; @j = j; end
  def to_s; "(#{@i}, #{@j})"; end

  def valid?(l)
    p = self
    p.i >= 0 and p.j >= 0 and p.i < l and p.j < l
  end
  
  def neighbors(l)
    points = []
    p = self
    if ( (p.i == (l - 1)) and (p.j == (l - 1)) )
      return []
    end

    #right
    if (_p = P.new(p.i, p.j + 1)).valid?(l)
      points << _p
    end
    #left
    if (_p = P.new(p.i, p.j - 1)).valid?(l)
      points << _p
    end
    #up
    if (_p = P.new(p.i - 1, p.j)).valid?(l)
      points << _p
    end
    #down
    if (_p = P.new(p.i + 1, p.j)).valid?(l)
      points << _p
    end

    return points
  end
end

class Grid
  attr_reader :grid, :length, :q, :new_grid
  def initialize
    @grid ||= File.read("files/P083.txt").split("\n").map(&:strip).map{|l| l.split(",").map(&:strip).map(&:to_i) }

    #test grid
    # @grid ||= [
    #   [131, 673, 234, 103,  18],
    #   [201,  96, 342, 965, 150],
    #   [630, 803, 746, 422, 111],
    #   [537, 699, 497, 121, 956],
    #   [805, 732, 524,  37, 331]
    # ]
    # @grid ||= [
    #   [131, 673, 234,   1,  18],
    #   [201,  96, 342,   1, 150],
    #   [630,   1, 746,   1, 111],
    #   [537,   1,   1,   1, 956],
    #   [805, 732, 524,  37, 331]
    # ]
    @length = @grid.length
    @new_grid = Array.new(@length, Float::MAX){ Array.new(@length, Float::MAX) }

    #initiate
    @q = Q.new
    @q.q( [ [nil, P.new(0, 0)] ] )
    process
  end

  def print_grid(grid)
    grid.each{|r| puts r.inspect }
  end

  def process

    loop do 
      p1, p2 = @q.dq
      break if p1.nil? and p2.nil?
      # puts "p1: #{p1}, p2: #{p2}"
      if p1.nil?
        @new_grid[p2.i][p2.j] = @grid[p2.i][p2.j]
        @q.q( p2.neighbors(@length).map{|t| [p2, t] } )
      else
        if @new_grid[p1.i][p1.j] + @grid[p2.i][p2.j] < @new_grid[p2.i][p2.j]
          @new_grid[p2.i][p2.j] = @new_grid[p1.i][p1.j] + @grid[p2.i][p2.j]
          @q.q( p2.neighbors(@length).map{|t| [p2, t] } )

        end


      end
      
    end
    # print_grid(@new_grid)
    puts @new_grid[@length - 1][@length - 1]


  end




end

Grid.new







