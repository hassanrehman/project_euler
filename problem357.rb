require 'set'
require 'prime'
require './utility.rb'

s = <<-STR
Consider the divisors of 30: 1,2,3,5,6,10,15,30.
It can be seen that for every divisor d of 30, d+30/d is prime.

Find the sum of all positive integers n not exceeding 100 000 000
such that for every divisor d of n, d+n/d is prime.
STR

MAX = 100_000_000
# MAX = 5_000
MAX_PRIMES = MAX

class Store
  def self.populate
    init_primes
    init_squares
  end

  def self.init_primes
    puts "populating primes .. "
    s = Time.now
    @@_all_primes = Array.new(MAX_PRIMES)
    Prime.each(MAX_PRIMES, Prime::MyGenerator.new){|p| @@_all_primes[p] = true }
    puts "takes #{(Time.now - s).round(2)}s"
  end

  def self.primes
    @@_all_primes
  end

  def self.init_squares
    puts "populating sqrts .. "
    s = Time.now
    @@_all_sqrts = Array.new(MAX)
    (1..(Math.sqrt(MAX).to_i + 1)).each do |i| 
      (i.sq..(i+1).sq).each{|j| @@_all_sqrts[j] = i }
    end
    puts "takes #{(Time.now - s).round(2)}s"
  end

  def self.squares
    @@_all_sqrts
  end
end

class Fixnum
  def divisors
    n = self
    (2..(n.sqrt + 1) ).select{|d| n % d == 0 }
  end

  def sq
    self*self
  end

  def sqrt
    Store.squares[self]
  end

  #d.x(n) = d + n / d
  def x(d)
    d + self / d
  end

  def is_prime?
    !Store.primes[self].nil?
  end

  def is_it?
    n = self
    return false if !(n+1).is_prime?   #divisor = 1 and n

    #special check for even numbers ... to make things faster
    #we can do this just because the main loop outside is only going on even numbers
    return false if !(n/2 + 2).is_prime?

    # puts "here: #{n}"
    (3..(n.sqrt)).each do |d|
      # puts "trying?: #{d}"
      if n % d == 0   #this is a divisor
        # puts "divisor: #{d}, x: #{n.x(d)}, is_prime?: #{x.is_prime?}"
        return false if !n.x(d).is_prime?
      end
    end
    return true
  end

end

Store.populate

#I have 8427 for n = 1000, and 79601 for n = 5000.
# https://github.com/mryingster/ProjectEuler/blob/master/problem_357.c

#this has a really interesting thing about prime division
#  If n is divisible by p^2 for some prime p, and p + n/p will be a multiple of p and thus not a prime.
#https://apps.topcoder.com/forums/%3bjsessionid=386C26913D2FAC71070424E9C1C2B12E?module=Thread&threadID=726029&start=0&mc=6#1448791

t = Time.now
sum = 1
(0..MAX).step(2) do |n|
  if n % 1000_000 == 0
    puts "n: #{n}"
  end
  if n.is_it?
    # divs = i.divisors
    # puts "#{i} - (#{divs.length}) #{divs.inspect}"
    sum += n
  end
end
puts "Time: #{t.elapsed}s"

puts sum





