def process
	index = 1
	for digits in 2..16
		max = 9*digits
		
		for base in 2..max
			p = 1
			while true
				try = base**p
				trystr = try.to_s
				break if trystr.length > digits
				if trystr.length != digits
					p += 1
					redo
				end
				sum = 0
				trystr.unpack('a1'*digits).collect { |y| y.to_i }.each { |x| sum += x }
				if sum == base
					puts "a#{index}: #{base}^#{p} = #{try}"
					index += 1
				end
				p += 1
			end
		end
		
		
	end
end
process