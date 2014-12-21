require "./utility.rb"
#If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, 
#there are exactly three solutions for p = 120.

#{20,48,52}, {24,45,51}, {30,40,50}

#For which value of p ≤ 1000, is the number of solutions maximised?


=begin

a = m^2 - n^2 , b = 2mn , c = m^2 + n^2
a + b + c

p = 2m2 + 2mn

p = 2m(m + n)

number of solutions for m > n
=end

def p(m, n)
  2*m*(m+n)
end

def tripple(m, n)
  [m*m - n*n, 2*m*n, m*m + n*n].sort
end

def process
  ps = {}
  (1..1000).to_a.each do |n|
    ((n+1)..(2000)).to_a.each do |m|
      _p = p(m, n)
      break if _p > 1000
      t = tripple(m, n)
      ps[_p] ||= []
      ps[_p] << t
      ps[_p].uniq!
      (2..1000).to_a.each do |i|
        new_t = t.map{|a| a*i }.sort
        break if new_t.sum > 1000
        ps[new_t.sum] ||= []
        ps[new_t.sum] << new_t
        ps[new_t.sum].uniq!
      end
    end
  end
    
  #get the one with the max number of tripples
  max_count = 0
  tripples = nil
  sum = 0
  ps.each do |p, ts|
    if (count = ts.count) > max_count
      max_count = count
      tripples = ts
      sum = p
    end
  end

  return sum

end

puts process