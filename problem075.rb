class Array
  def sum
    inject(0){ |s, i| s += i }
  end
end

def gcd(a, b)
  while b != 0
    t = b
    b = a % b
    a = t
    end
  return a
end
def triple(m, n)
  a = 2*m*n
  b = (m+n)*(m-n)
  c = m*m+n*n
  [a, b.abs, c].sort
end


MAXSUM = 1500000
sqrt_maxsum = Math.sqrt(MAXSUM)
sums = []
(1..sqrt_maxsum).step(2) do |m|
  (2..sqrt_maxsum).step(2) do |n|
    if gcd(m, n) == 1   #by principle .. 
      sum = triple(m, n).sum

      #a multiple of a triple is also a triple .. count
      (sum..MAXSUM).step(sum) do |s|
        sums[s] ||= 0
        sums[s] += 1
      end
    end
  end
end

#now count the ones that have just one triple
puts sums.count(1)
