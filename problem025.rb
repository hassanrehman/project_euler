require "./utility.rb"

indexes = [1, 2, 3]
numbers = [1, 1, 2]

loop do 
  indexes.map!{|a| a+1 }
  numbers = (numbers << (numbers[-1] + numbers[-2])).last(3)
  break if numbers[-1] >= 10**999
end

puts indexes[-1]