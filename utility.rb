class Array
  def sum
    self.inject(&:+)
  end
  def multiply
    self.inject(&:*)
  end
end

class Fixnum
  def abs
    (self < 0) ? -1*self : self
  end

  def factorial
    return 1 if self == 1 or self == 0
    return 2 if self == 2

    (2..self).inject(&:*)
  end

  #calculates nCr
  def C(r)
    factorial / (r.factorial * (self-r).factorial)
  end
end