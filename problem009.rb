require './utility.rb'

#A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

#a**2 + b**2 = c**2
#For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.

#There exists exactly one Pythagorean triplet for which a + b + c = 1000.
#Find the product abc.


#When m and n are any two positive integers (m < n):

#a = n**2 - m**2
#b = 2nm
#c = n**2 + m**2

def gen(m, n)
  [n*n - m*m, 2*n*m, n*n + m*m].sort
end

limit = 100
(1..limit).each do |m|
  ((m+1)..limit).each do |n|
    t = gen(m, n)
    puts t.multiply if t.sum == 1000
  end
end