require "./utility.rb"

puts (0..9).to_a.map(&:to_s).permutation.to_a.map{|a| a.join.to_i }.sort[10**6 - 1]