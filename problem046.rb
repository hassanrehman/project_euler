require "./utility.rb"

=begin
It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.

9 = 7 + 2×12
15 = 7 + 2×22
21 = 3 + 2×32
25 = 7 + 2×32
27 = 19 + 2×22
33 = 31 + 2×12

c = p + 2*x^2

It turns out that the conjecture was false.

What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?
=end

class P046

  def initialize
    @primes = Prime.each(100_000).to_a[1..-1]
    @is_prime = []
    @primes.each{|p| @is_prime[p] = true }
    process
  end

  def process
    c = 33
    loop do 
      unless @is_prime[c]
        unless x?(c)
          puts c
          break
        end
      end
      c += 2
    end
  end

  def x?(c)
    raise "increase primes" if c > @primes[-1]

    relevant_primes = @primes.select{|p| p < c }
    relevant_primes.each do |p|
      _x2 = ((c - p)/2).to_i
      _x = Math.sqrt(_x2).to_i
      return true if _x*_x == _x2
    end
    return false
  end

end

P046.new







