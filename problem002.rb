require './utility.rb'

fibs = [1, 2]
loop do
  new_value = fibs[-1] + fibs[-2]
  break if new_value > 4_000_000
  fibs << new_value
end

puts fibs.select{|a| a%2 == 0 }.sum