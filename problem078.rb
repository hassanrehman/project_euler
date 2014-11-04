#pentagonal number
def g(k)
  (k*(3*k - 1))/2
end

#base number for generalized pentagonal numbers
def k(m)
  m%2 == 0 ? -1*(m/2) : (m+1)/2
end

def abs(n)
  n < 0 ? -1*n : n
end

#number of integer partitions
$ps = [1, 1, 2]
def p(n)
  return $ps[n] unless $ps[n].nil?

  m = 1
  sum = 0.to_i
  #tmp = []
  loop do
    gk = g(k(m))
    break if gk > n
    sum += (-1)**abs(k(m)-1) * ($ps[n]||p(n - gk))
    sum %= 1000000   #keep it within required limits
    m += 1    
  end

  $ps[n] = sum
  return sum
end

n = 1000
loop do
  if p(n) % 1000000 == 0
    puts n
    break
  end
  n+=1
end