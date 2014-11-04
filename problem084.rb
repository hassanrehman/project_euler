class Array
  def sum
    self.inject(&:+)
  end
end
class Dice
  def roll(faces = 4)
    (rand(faces) + 1) + (rand(faces) + 1)
  end
end

class Game

  def initialize
    @board = %w(GO A1 CC1 A2 T1 R1 B1 CH1 B2 B3 JAIL C1 U1 C2 C3 R2 D1 CC2 D2 D3 FP E1 CH2 E2 E3 R3 F1 F2 U2 F3 G2J G1 G2 CC3 G3 R4 CH3 H1 T2 H2)
    @current = "GO"
    @community_chest = %w(GO JAIL)
    @chance = {values: %w(GO JAIL C1 E3 H2 R1 nextR nextR nextU back3), 
      nextR: {"CH1" => "R2", "CH2" => "R3", "CH3" => "R1"},
      nextU: {"CH1" => "U1", "CH2" => "U2", "CH3" => "U1"}}

    @dice = Dice.new
  end

  def index(of)
    @board.index(of)
  end

  def current
    @current
  end

  def community_chest
    next_at = @community_chest[rand(15)]
    if next_at
      @current = next_at
    end
  end

  def chance
    next_at = @chance[:values][rand(15)]
    if next_at == "nextR"
      @current = @chance[:nextR][@current]
    elsif next_at == "nextU"
      @current = @chance[:nextU][@current]
    elsif next_at == "back3"
      move(37)  #sets the current on its own
    else
      if next_at
        @current = next_at
      end
    end

  end

  def move(moves)
    at = @board.index(@current)
    at += moves
    at -= @board.length if at >= @board.length
    @current = @board[at]
    if @current == "G2J"
      @current = "JAIL"
    elsif @current.start_with?("CC")
      community_chest
    elsif @current.start_with?("CH")
      chance
    end
  end

  def roll
    move(@dice.roll)
  end

  def rolls(count)
    debug = false
    position_count = @board.inject({}){|s, i| s.merge!(i => 0)  }
    count.times do 
      puts "at: #{@current}" if debug
      moves = @dice.roll
      puts "moves: #{moves}" if debug
      move(moves)
      puts "new: #{@current}" if debug
      position_count[@current] += 1
      puts "" if debug
    end
    return position_count
  end
end

g = Game.new
position_count = g.rolls(2_000_000)
total = position_count.values.sum
Hash[position_count.sort{|a, b| b[1] <=> a[1] }.first(3)].each do |k, v|
  puts "#{k} (#{g.index(k)})\t#{((v*100)/total.to_f).round(2)}"
end

