require "./utility.rb"

=begin
A number chain is created by continuously adding the square of the digits in a number to form a new number until it has been seen before.

For example,

44 → 32 → 13 → 10 → 1 → 1
85 → 89 → 145 → 42 → 20 → 4 → 16 → 37 → 58 → 89

Therefore any chain that arrives at 1 or 89 will become stuck in an endless loop. What is most amazing is that 
EVERY starting number will eventually arrive at 1 or 89.

How many starting numbers below ten million will arrive at 89?
=end



class P092
  def initialize
    @arriving_at_89 = {89 => true}
    process
  end

  def next_num(n, prev_result=nil)
    i = n
    to_return = 0
    loop do
      j = i%10
      to_return += j*j
      i /= 10
      break if i == 0
    end
    return to_return
  end

  def populate(max_possible_sum)
    (1..max_possible_sum).each do |n|
      next if n == 1 or n == 89
      i = n
      loop do 
        i = next_num(i)
        if i == 1 or i == 89
          @arriving_at_89[n] = true if i == 89
          break
        end
      end
    end
  end

  def process
    max_possible_sum = next_num(10**7 - 1)
    populate(max_possible_sum)
    count = 0
    ranger = (0..9).to_a.map{|a| a*a }
    ranger.each do |i1|
      ranger.each do |i2|
        ranger.each do |i3|
          ranger.each do |i4|
            ranger.each do |i5|
              ranger.each do |i6|
                ranger.each do |i7|
                  sum = i1+i2+i3+i4+i5+i6+i7
                  count += 1 if @arriving_at_89[sum]
                end
              end
            end
          end
        end
      end
    end

    puts count

  end


end

P092.new