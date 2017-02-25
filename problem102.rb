
class Fixnum
  def abs
    self < 0 ? -1*self : self
  end
end

class Point
  attr_reader :x, :y
  def initialize(x, y); @x = x; @y = y; end
  def to_s; "(#{x}, #{y})"; end
  def self.o; new(0, 0); end
end

class Triangle
  attr_reader :a, :b, :c

  def initialize(a, b, c)
    @a = a; @b = b; @c = c
  end

  #http://www.mathopenref.com/coordtrianglearea.html
  def area
    ( ( a.x*(b.y - c.y) + b.x*(c.y - a.y) + c.x*(a.y - b.y) ) / 2.0 ).abs
  end

  def has_origin?
    o = Point.o
    (Triangle.new(o, a, b).area + Triangle.new(o, a, c).area + Triangle.new(o, b, c).area) == area
  end
end

puts begin
  File.readlines("files/P102.txt").map(&:strip).select{|line|
    ax,ay,bx,by,cx,cy = line.split(",").map(&:strip).map(&:to_i)
    a, b, c = [Point.new(ax, ay), Point.new(bx, by), Point.new(cx, cy)]
    Triangle.new(a, b, c).has_origin?
  }.length
end







