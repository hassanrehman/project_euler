require "./utility.rb"
require 'prime'

#The number 3797 has an interesting property. 
#Being prime itself, it is possible to continuously remove digits from left to right, 
#and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.

#Find the sum of the only eleven primes that are both truncatable from left to right and right to left.

#NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

def is_truncable(p)
  p = p.to_s
  l2r = (1...p.length).to_a.map{|a| p[a..p.length] }.map(&:to_i).all?{|a| Prime.prime?(a) }
  r2l = (1...p.length).to_a.map{|a| p[0...a] }.map(&:to_i).all?{|a| Prime.prime?(a) }
  (l2r && r2l)
end

truncables = []
Prime.each do |p|
  next if p < 10
  if is_truncable(p)
    truncables << p
    puts "No. #{truncables.length}, p: #{p}, sum: #{truncables.sum}"
  end
  break if truncables.length == 11

end