require "./utility.rb"

puts (1..1000).to_a.map{|i| i**i }.sum.to_s.split("").last(10).join