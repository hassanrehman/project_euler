target = 100

ways = [1]+[0]*target
for i in 1...100
  for j in i..target
    ways[j] += ways[j-i]
  end
end

puts ways[target]