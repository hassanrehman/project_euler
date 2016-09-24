require './utility'

#1_2_3_4_5_6_7_8_9_0

#if r is the solution to 1_2_3_4_5_6_7_8_9
#then solution = r*10

max = 19293949596979899
max_sq = Math.sqrt(max).ceil

min = 10203040506070809
min_sq = Math.sqrt(min).ceil + 1    #checked in console until i got in the end

#to get 9 in the end we need 3 or 7 in the end of the number
#try 23*23 and 57*57 ..  the first digit is 9 .. 
#so starting from the top .. we come down
#reducing 4 if it ends with 7 or 6 if it ends with 3

is_in_form = Proc.new do |n|
    n.to_s.split("").in_groups_of(2).map{|k, v| k }.join == "123456789"
  end

n = max_sq
while n > min_sq do 
  break if is_in_form.call( n**2 )
  n -= ( n % 10 == 7 ? 4 : 6 )
end

puts n*10

