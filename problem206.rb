start_value = 101010103
end_value = 141421354

def test(num)
	str = num.to_s
	str[-1] == 57 and str[-3] == 56 and str[-5] == 55 and str[-7] == 54 and str[-9] == 53 and str[-11] == 52 and str[-13] == 51 and str[-15] == 50
end

four = true
i = start_value
while i < end_value
	sq = i*i
	if test(sq)
	  puts "#{i} : #{sq}"
	  sleep(0.5)
	end
	
	if four
	  i += 4
	  four = false
	else
	  i += 6
	  four = true
	end
end
