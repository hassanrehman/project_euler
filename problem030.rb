require "./utility.rb"

def is_fifth(n)
  n.to_s.split("").map(&:to_i).map{|i| i**5 }.sum == n
end

i = 11
fifths = []
loop do 
  if is_fifth(i)
    fifths << i
    puts "#{fifths.inspect} = #{fifths.sum}"
  end
  i += 1
  break if i >= 10**6
end