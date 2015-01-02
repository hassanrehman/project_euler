require "./utility.rb"

=begin
The 5-digit number, 16807=7**5, is also a fifth power. Similarly, the 9-digit number, 134217728=8**9, is a ninth power.

How many n-digit positive integers exist which are also an nth power?
=end

#if ceil of x*Math.log(9) is == x then count the numbers for this x else stop looking for them


#no of digits in x**n

def pow_digits(a, b)
  (b*Math.log10(a)).to_i + 1
end

x = 1
count = 0
loop do 
  break if pow_digits(9, x) < x

  (1..9).to_a.reverse.each do |n|
    digits = pow_digits(n, x)
    if digits == x
      count += 1 
    elsif digits > x
      break
    end
    
  end

  x += 1
end

puts count