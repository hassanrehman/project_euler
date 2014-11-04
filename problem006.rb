require './utility.rb'

limit = 100
puts (1..limit).to_a.sum**2 - (1..limit).to_a.map{|a| a**2 }.sum