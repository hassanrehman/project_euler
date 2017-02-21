class Fixnum
  def is_bouncy?
    return false if self < 100

    n = self
    is_up = first = second = third = nil

    while n > 0
      d = n % 10
      n /= 10

      if first.nil?
        first = d
        next
      end

      # return false if first == 1

      if second.nil?
        if d != first
          second = d
          is_up = ( first > second )
        end
        next
      end
      # puts "first: #{first}, second: #{second}, is_up: #{is_up}"

      next if d == third
      third = d
      # puts "second: #{second}, third: #{third}"
      return true if ( is_up and third > second ) or ( !is_up and third < second )

      second = third
    end

    return false
  end
end


bouncy_count = 0
n = 100
loop do 
  (bouncy_count += 1) if n.is_bouncy?
  percentage = bouncy_count * 100 / n.to_f

  # puts "n: #{n}, count: #{bouncy_count}, percentage: #{percentage}%"
  break if percentage >= 99
  n += 1
end


puts "result: #{n}"







