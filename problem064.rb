
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


def period(a, max_attempts=1000)

  x = X.new(1, a, 0, 1)
  so_far = {x.dup => true}

  period = 0
  max_attempts.times do 
    x = x.x
    if so_far[x].nil?
      so_far[x] = true
      period += 1
    else
      return period
    end
  end

  return 0

end

puts (2..10_000).to_a.reject{|n| X.sq(n).to_i**2 == n }.count{|n| (period(n) % 2) == 1 }







