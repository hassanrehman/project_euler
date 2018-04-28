fib = Enumerator.new do |r|
    i = 0
    j = 1

    a = 0
    b = 1

    x = 0
    y = 1
    loop do
      if i.to_s.length == j.to_s.length and i.to_s.length >= 25
        i /= 10
        j /= 10
      end

      i, j = j, i + j
      a, b = b, a + b
      # x, y = y, x + y

      a %= 10**15

      r << [i, a, x]
    end
  end

def check_top(n)
  n.to_s[0...9].split("").sort.join == "123456789"
end

def check_bottom(n)
  return false if Math.log(n, 10).to_i < 8
  n.to_s[-9..-1].split("").sort.join == "123456789"
end

def check_bottom1(n)
  return false if Math.log(n, 10).to_i < 8
  t = n
  f = Array.new(9, false)
  9.times do 
    r = t%10
    (return false) if (r == 0 or f[r-1])
    f[r-1] = true
    t /= 10
  end
  return true
end

def check_top1(n)
  digits = Math.log(n, 10).to_i
  t = n / (10**(digits - 8))
  check_bottom1(t)
end

fib.each_with_index do |(top_part, bottom_part), i|
  next if i <= 500

  if check_bottom(bottom_part) and check_top(top_part)
    puts i+1
    break
  end


end




