

#https://en.wikipedia.org/wiki/Partition_(number_theory)

def g(k)
  @@_gk ||= {}
  @@_gk[k] ||= ( (k * (3*k - 1)) /2 )
end

def sign(k)
  @@_signs ||= {}
  @@_signs[k] ||= ((-1)**(k-1)).to_i
end

def p(n)

  @@_pn ||= {}
  return @@_pn[n] if @@_pn[n]

  if n < 0
    sum = 0
  elsif n < 1
    sum = 1
  else
    #many of these are > n ...  if this isnt efficient enough .. we can reduce these by a LOT
    #to save recursions .. but they'd all give 0 from memory since p(n) remembers previous numbers
    #and negatives are static returns ..  
    ks = (n/2.0).ceil.times.flat_map{|i| [i + 1, -i - 1] }
    sum = ks.map{|k| sign(k) * p( n - g(k) ) }.inject(&:+)
    
  end
  @@_pn[n] = sum
  return sum
end


puts p(100) - 1





