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

def triple_sum(m, n)
  2*m*n + ( (m+n)*(m-n) ).abs + (m*m+n*n)
end


MAXSUM = 1500000
sqrt_maxsum = Math.sqrt(MAXSUM)
sums = Hash.new{|h, k| h[k] = 0 }
(1..sqrt_maxsum).step(2) do |m|
  (2..sqrt_maxsum).step(2) do |n|
    if gcd(m, n) == 1   #by principle .. to only get primitive
      sum = triple_sum(m, n)

      #a multiple of a triple is also a triple .. count
      (sum..MAXSUM).step(sum) do |s|
        sums[s] += 1
      end
    end
  end
end

#now count the ones that have just one triple
puts sums.select{|k, v| v == 1 }.count
