require "./utility.rb"


(2..9).to_a.reverse.each do |last|
  puts "searching in 1..#{last}"
  all_nums = (1..last).to_a
  ans = all_nums.permutation(last).to_a.reject{|a| a[-1] % 2 == 0 }.sort{|a, b| b <=> a }.find{|a| Prime.prime?(a.join.to_i) }
  if ans
    puts ans.join
    break
  end

end