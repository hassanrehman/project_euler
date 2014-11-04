require 'prime'
require './utility.rb'

#generates nth triangle sum
def triangle_number(n)
  (n*(1 + n))/2
end

def no_of_divisors(n)
  Prime.prime_division(n).map{|a| a[1] + 1 }.multiply
end

i = 5
loop do 
  n = no_of_divisors(t = triangle_number(i)) 
  if n > 500
    puts t
    break
  end
  i += 1
end
