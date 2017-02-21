=begin
  
  c = 3, r = 2
  3 - 1 + 1    +    3 - 2 + 1     +     3 - 3 + 1
  2 - 1 + 1         2 - 1 + 1           2 - 1 + 1
     6                 4                   2

  3 - 1 + 1    +    3 - 2 + 1     +     3 - 3 + 1
  2 - 2 + 1         2 - 2 + 1           2 - 2 + 1
     3                  2                  1

  ### generally
  considering only c .. 
  #
  #c - 1 + 1   +   c - 2 + 1   + c - 3 + 1  .....  c - c + 1
  #or:   c  +   c - 2    +   c - 3   ....  3 + 2 + 1
  #or sum of arithmetic series: c/2(c + 1)

  we do this r many times so t = number of rectangles:
  t = c(c+1) * r(r + 1) / 4

  #in our example: 3(4) * 2(3) / 4 = 18

=end

def t( r, c )
  ( r*(r + 1) * c*(c + 1) ) / 4
end

MAX = 2_000_000

#v is the difference between MAX .. we need the smallest of this
closest = { v: MAX, r: 1, c: 1, a: 1 }

r = 1
loop do 
  break if t(r, r) > MAX
  c = r
  loop do
    t = t(r, c)
    break if t > MAX

    diff = (t - MAX).abs
    if diff < closest[:v]
      closest = { v: diff, r: r, c: c, a: r*c }
      # puts closest.inspect
    end

    c += 1
  end
  r += 1

end


puts closest[:a]





