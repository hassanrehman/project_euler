#rotates the 5gon until the min outsider is the first element
def min_rotate(gon)
  min = gon.min{|a, b| a.first <=> b.first }
  gon.index(min).times { gon << gon.delete_at(0) }
  return gon
end

def min_rotated_5gon(perm, node_sum)
  d, h, b, f, j = found_nums = perm
  
  a = (node_sum + d + h) - (2*b + f + j)
  return nil if a < 1 or a > 10 or found_nums.include?(a)
  found_nums << a
  
  i = node_sum - (b + j)
  return nil if i < 1 or i > 10 or found_nums.include?(i)
  found_nums << i
  
  g = node_sum - (h + i)
  return nil if g < 1 or g > 10 or found_nums.include?(g)
  found_nums << g
  
  e = node_sum - (f + g)
  return nil if e < 1 or e > 10 or found_nums.include?(e)
  found_nums << e
  
  c = node_sum - (d + e)
  return nil if c < 1 or c > 10 or found_nums.include?(c)
  found_nums << c
  
  final_gon = min_rotate([[a, b, c], [d, c, e], [f, e, g], [h, g, i], [j, i, b]])
  puts final_gon.inspect
  str = final_gon.flatten.join
  
  return nil if str.length != 16
  
  return str
end

def get_16digit_5gons(node_sum)
  (1..10).to_a.permutation(5).to_a.collect do |perm|
    min_rotated_5gon(perm, node_sum)
  end.compact
end

start_time=Time.now

gons = []
(10..20).to_a.each do |node_sum|
  gons += get_16digit_5gons(node_sum)
end
gons.compact

puts gons.map(&:to_i).max
puts "Time: #{Time.now-start_time}"














