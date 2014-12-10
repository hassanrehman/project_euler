require 'prime'

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

class Time
  def elapsed(options={})
    default_options = {
      round_digits: 2
    }
    options = default_options.merge(options)
    elapsed = Time.now - self
    elapsed.round(options[:round_digits])
  end
end
