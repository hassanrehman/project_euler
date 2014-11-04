require './utility.rb'

puts (1..999).to_a.select{|a| a%3 == 0 or a%5 == 0 }.sum