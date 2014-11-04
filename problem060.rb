class Array
	#perform binary search
	def include?(elem)
		return false if self.size == 0
		#apply linear if size is less than 5
		if self.size < 5
			self.each{|v| return true if elem==v }
			return false
		end
		#apply binary if more than 5
		si = 0
		ei = self.size-1
		while si < ei
			mid = ( si + ei ) / 2
			return true if elem == self[mid] or elem == self[si] or elem == self[ei]
			elem > self[mid] ? si = mid+1 : ei = mid-1
		end
		return false
	end
end
class Prime
  attr_accessor :primes
  def initialize(limit)
	#generate primes
	print "generating primes..."
	@primes = [2, 3, 5, 7]
    (9..limit).to_a.each{ |v| @primes << v if is_prime_raw(v) }
	print "done\n"
  end
  def is_prime_raw(n)
	return true if n == 2 or n == 3 or n == 5 or n == 7
	limit = Math.sqrt(n).to_i + 1
	for p in @primes
		break if p >= limit
		return false if n%p == 0
	end
	return true
  end
  def is_prime(n)
	@primes.include?(n) or is_prime_raw(n)
  end
end
$p = Prime.new(10000)
class Fixnum
	def is_prime_with?(list)
		list.each{|n| return false unless ($p.is_prime("#{self}#{n}".to_i) and $p.is_prime("#{n}#{self}".to_i)) }
		return true
	end
end
primes = $p.primes
start = Time.now
for a in 0...primes.length
	for b in (a+1)...primes.length
		if primes[b].is_prime_with?([primes[a]])
			for c in (b+1)...primes.length
				if primes[c].is_prime_with?([primes[a], primes[b]])
					for d in (c+1)...primes.length
						if primes[d].is_prime_with?([primes[a], primes[b], primes[c]])
							for e in (d+1)...primes.length
								if primes[e].is_prime_with?([primes[a], primes[b], primes[c], primes[d]])
									puts "*"*80
									puts "#{primes[a]}, #{primes[b]}, #{primes[c]}, #{primes[d]}, #{primes[e]}"
									puts "*"*80
									puts "Sum: #{primes[a]+primes[b]+primes[c]+primes[d]+primes[e]}"
									puts Time.now - start
									exit
								end
							end
						end
					end
				end
			end
		end
	end
end
