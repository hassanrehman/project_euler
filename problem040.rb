s = (1..200_000).to_a.join("")
puts (0..6).to_a.map{|a| s[10**a-1] }.map(&:to_i).inject(&:*)
