

def reverse(n)
  n.to_s.split("").reverse.join.to_i
end

def reverse_add(n)
  reverse(n) + n
end

def all_odd(n)
  n.to_s.split("").map(&:to_i).all?{|i| i % 2 == 1 }
end

def reversible(n)
  all_odd( reverse_add(n) )
end

def count( digits, zeros = false, debug=false )
  range_start = 10**(digits-1)
  range_end = (10**digits)-1

  done = {}
  count = 0
  (range_start..range_end).each_with_index do |n, i|
    # puts "#{n} + #{reverse(n)} = #{n + reverse(n)}" if debug
    if (zeros or (!zeros and n%10 != 0)) and !done[n] and reversible(n)
      done[n] = true
      done[reverse(n)] = true
      (puts "#{n} + #{reverse(n)} = #{n + reverse(n)}") if debug
      count += 1
    end
  end
  count*2
end


#3 digit algo
#n: 2 to 8
#  m > n such that m+n is odd and > 10
#  count(m)*5 (0, 1, 2, 3, 4)
#
#if it's to be even .. then:
#  m > n such that m+n is even and < 10 (no carry forward)
def threes(odd=true)
  total_count = 0
  (0..9).each do |n|
    ms = if odd
        (0..9).select{|m| m+n > 10 && (((m+n) % 2) == 1) }
      else  #even
        (0..9).select{|m| m+n < 10 && (((m+n) % 2) == 0) }
      end
    # puts "n: #{n}, ms: #{ms.join(" ")}"
    total_count += ms.count
  end
  return total_count
end

#### evens
inner = { 2 => count(2, true) }
outer = { 2 => count(2, false) }

outer[4] = outer[2]*inner[2]
inner[4] = inner[2]*inner[2]

outer[6] = outer[2]*inner[4]
inner[6] = inner[2]*inner[4]

outer[8] = outer[2]*inner[6]

##### odds
#for 3 .. the inner digit has 0,1,2,3,4
#for outer to be odd .. we calculate (and count returns the same number .. but the theory is important for the rest)
outer[3] = threes(true)*5

#5 is 0 .. since it has _ ___ _   and for outer to be odd ... inner needs to be even and carry, which is not possible
outer[5] = 0

#for 3 .. we have 1 2 343 2 1
#where 1 and 3 will be odd and carrying .. and 2 will be even and not carrying
#4 would be 5 just like it was for 3
outer[7] = threes(true)*threes(false)*threes(true)*5

#9, for the same logic as 5 .. doesn't contain any sols

puts outer.inspect
puts inner.inspect

# puts "counted: #{count(3, false, true)}"
# puts "found: #{outer[5]}"


puts "result: #{outer.values.inject(&:+)}"



