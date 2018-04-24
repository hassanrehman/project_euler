require 'set'

class Sudoku
  attr_accessor :rows, :name
  def initialize(rows, name=nil)
    @name = name
    @rows = rows   #.map{|r| r.split("").map(&:to_i) }
    @indices = (0..8).to_a.product((0..8).to_a)
  end

  def to_s
    r = @rows.map{|r| r.each_slice(3).to_a.map(&:join).join("  ") }
    s = r.each_slice(3).to_a.map{|_r| _r.join("\n") }.join("\n\n")
    [@name, s].join("\n")
  end
  def print
    puts "#{self}\n\n"
  end

  def possibilities(r, c)
    (return [@rows[r][c]]) if @rows[r][c] != 0   #if there is a number there, that's the only possibility

    t = Set.new
    t += @rows[r].select{|_c| _c > 0 }   #on row

    t += @rows.map{|row| row[c] }.select{|_r| _r > 0 }

    tl_r, tl_c = [(r / 3)*3, (c / 3)*3]
    t += [0, 1, 2].product([0, 1, 2]).map{|i, j| @rows[tl_r+i][tl_c+j] }   #on box

    (0..9).to_a - t.to_a
  end

  def single_possibilities!
    something_found = false
    @indices.each do |i, j|
      if rows[i][j] == 0 and (_p = possibilities(i, j)).length == 1
        rows[i][j] = _p[0]
        something_found = true
      end
    end

    #keep going .. until there is one such single possibility
    single_possibilities! if something_found
  end

  def complete?
    (return false) if rows.any?{|r| r.any?{|c| c == 0 } }
    (return false) if rows.any?{|row| row.sort.join != "123456789" }
    (return false) if rows.transpose.any?{|row| row.sort.join != "123456789" }
    #TODO: check for boxes?
    return true
  end

  def clone
    new_g = Sudoku.new( @rows.map(&:clone) )
    yield(new_g) if block_given?
    return new_g
  end

  def solve!
    single_possibilities!
    (return true) if complete?

    #since the single possibilities are all accounted for .. 
    #and it's not possible to have 0 possibilities in a sudoku .. 
    #get the first 0 .. find it's possibilities and recurse
    i, j = @indices.select{|_i, _j| rows[_i][_j] == 0 }.first
    possibilities(i, j).each do |n|
      new_g = clone{|g| g.rows[i][j] = n }
      if new_g.solve!
        @rows = new_g.rows
        return true
      end
    end

    return false
  end

  def result
    @rows[0][0..2].join.to_i
  end

end


lines = File.read("files/p096_sudoku.txt").split("\n")
grids = (0...50).map{|i| Sudoku.new( lines[ (i*10+1)..(i*10+9) ].map{|r| r.split("").map(&:to_i) }, lines[i*10] ) }

ans = 0
grids.each do |g|
  print g.name
  t = Time.now
  resolved = g.solve!
  puts "  done: #{resolved} took #{(Time.now - t).round(2)}s -- #{g.result}"
  ans += g.result
end
puts ans

# puts grids.select(&:solve!).map(&:name).sort

# g = grids[1]
# g.print
# puts g.solve!
# g.print





