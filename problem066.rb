#http://www.numbertheory.org/pdfs/keith_midpoint.pdf

#2. https://en.wikipedia.org/wiki/Pell%27s_equation#Fundamental_solution_via_continued_fractions

#according to 2 .. we need to contunally find fractions h/k where 

#for explanation on why X is like that ... see problem064.rb
class X
  attr_reader :r, :a, :b, :c, :n, :x

  def self.sq(n)
    @@_sqs ||= {}
    @@_sqs[n] ||= Math.sqrt(n)
  end
  #
  #x = (r*a.sq + b) / c
  def initialize(r, a, b, c)
    @r = r; @a = a; @b = b; @c = c
    normalize
  end

  def normalize
    g = r.gcd(b).gcd(c)
    @r /= g; @b /= g; @c /= g
  end

  def n
    @n ||= ( ((X.sq(a) * r) + b).to_f / c.to_f ).to_i
  end

  #after due algebra .. 
  def x
    @x ||= X.new( c*r, a, (-1*c*(b - c*n)), (r*r*a - (b - c*n)*(b - c*n)) )
  end

  def eql?(y)
    [r, a, b, c] == [y.r, y.a, y.b, y.c]
  end
  alias_method :==, :eql?

  def inspect
    "x = (#{r} * sq( #{a} ) + #{b}) / #{c}"
  end
  alias_method :to_s, :inspect

  def dup
    X.new(r, a, b, c)
  end

  def hash
    [r, a, b, c].hash
  end
end

class Rational
  alias_method :x, :numerator
  alias_method :y, :denominator
end

class Fixnum
  def perfect_square?
    Math.sqrt(self).to_i ** 2 == self
  end
end

#see problem065.rb for continued fractions with integers and their recursion
#the principle is the same .. but the fractions used are several instead of just the 10th and 100th convergence

def get_fraction( pattern )
  r = nil
  pattern.reverse.each_with_index do |n, i|
    r = (i == 0 ? n : n + Rational(1, r))
  end
  return r
end


def get_diophantine_pair( d )
  x = X.new(1, d, 0, 1)

  ns = [x.n]
  x = x.x

  fraction = nil
  loop do 
    ns << x.n
    x = x.x
      
    f = get_fraction( ns )
    if f.x**2 - d * (f.y**2) == 1
      return f.x, f.y
    end
  end
  return nil, nil

end


xs = (2..1000).reject(&:perfect_square?).inject({}){|s, d| s.merge!( d => get_diophantine_pair(d)[0] ) }

max_x = xs.values.max
puts xs.select{|d, x| x == max_x }.keys.first










