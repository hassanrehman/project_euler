require_relative "utility.rb"

#expects num to be array of integers (digits of the number)
#
#starts from the last digit and increments a number until it hits max
#after which, we go to what normally is 10
#
def next_num(num, max=9, min=0)
  arr = num
  done = false
  for i in 0...arr.length
    index = arr.length - i - 1
  	if arr[index] == max
  	  arr[index] = min
  	  next
  	end
	  arr[index] += 1
    done = true
	  break
  end
  arr = [min] + arr if not done
  arr.join_to_i
end

def get_sums(start_num, end_num, number_max, number_min)
  num = start_num
  sums = Hash.new{|h, k| h[k] = 0 }
  loop do 
  	int_arr = num.split
  	sum = int_arr.sum
  	sums[sum] += 1
  	num = next_num(int_arr, number_max, number_min)
  	break if num == end_num
  end
  sums
end

start_time = Time.now
puts "starting petes:"
petes_sums = get_sums(111111111, 444444444, 4, 1)
puts "time: #{Time.now - start_time} seconds"

start_time = Time.now
puts "starting colins:"
colins_sums = get_sums(111111, 666666, 6, 1)
puts "time: #{Time.now - start_time} seconds"

pete_wins = 0
petes_sums.each do |p_sum, p_count|
  colins_sums.each do |c_sum, c_count|
    pete_wins += p_count*c_count if p_sum > c_sum
  end
end
total_games = 4**9 * 6**6
puts "real total: #{petes_sums.values.sum + colins_sums.values.sum}"
puts "total: #{total_games}, pete_wins: #{pete_wins}, prob: #{prob = (pete_wins.to_f/total_games.to_f)}"
puts "result: #{prob.round(7)}"






