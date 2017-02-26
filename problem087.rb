
require './utility.rb'
require 'set'

MAX = 50*(10**6)
# MAX = 50

primes = []
Prime.each(8000, Prime::MyGenerator.new){|p| primes << p }

counts = Set.new
primes.each do |p1|
  pp1 = p1**2
  break if pp1 > MAX
  primes.each do |p2|
    pp2 = pp1 + p2**3
    break if pp2 > MAX
    primes.each do |p3|
      pp3 = pp2 + p3**4

      break if pp3 > MAX
      # puts "#{p1}, #{p2}, #{p3}: #{pp3}"
      counts << pp3
    end
  end
end

puts counts.length

