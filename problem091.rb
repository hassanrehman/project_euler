THRESHOLD = 0.00005

def grad(x1, y1, x2, y2)
  return "inf" if (x2 - x1) == 0
  return (y2 - y1).to_f / (x2 - x1).to_f
end

def abs(n)
  n < 0 ? n*-1 : n
end

def perpendicular(line1, line2)
  return true if (line1 == 0 and line2 == "inf") or (line2 == 0 and line1 == "inf")
  return false if line1 == "inf" or line2 == "inf"

  return abs(line1*line2 + 1) < THRESHOLD
end

def is_right_triangle(p1, p2)
  p = [0, 0]

  #if both coordinates are exactly same, remove the sucker
  return false if p1 == [0, 0] or p2 == [0, 0] or p1 == p2

  pp1 = grad(*p, *p1)
  pp2 = grad(*p, *p2)
  p1p2 = grad(*p1, *p2)

  return (perpendicular(pp1, pp2) or perpendicular(pp1, p1p2) or perpendicular(pp2, p1p2))

end

p = [0, 0]

count = 0
LIMIT = 50
$pairs = {}

for x1 in (0..LIMIT)
  for y1 in (0..LIMIT)
    for x2 in (0..LIMIT)
      for y2 in (0..LIMIT)

        p1 = [x1, y1]
        p2 = [x2, y2]

        # pair = [p1.join, p2.join].sort.join(",")
        # next unless $pairs[pair].nil?
        # $pairs[pair] = true


        yes = is_right_triangle(p1, p2)
        #puts "#{p1.inspect}, #{p2.inspect}, tripple?: #{yes}"
        count += 1 if yes

      end
    end
  end
end

puts count/2
