

a = (2..100).to_a
b = (2..100).to_a

puts (a.permutation(2).to_a + a.map{|i| [i, i] }).map{|n, p| n**p }.uniq.count