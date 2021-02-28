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

def is_right_triangle(x1, y1, x2, y2)
  #if coordinates are repeated
  if (x1 == 0 and y1 == 0) or
    (x2 == 0 and y2 == 0) or
    (x1 == x2 and y1 == y2)
    return false
  end

  pp1 = grad(0, 0, x1, y1)
  pp2 = grad(0, 0, x2, y2)
  p1p2 = grad(x1, y1, x2, y2)

  return (perpendicular(pp1, pp2) or perpendicular(pp1, p1p2) or perpendicular(pp2, p1p2))
end

count = 0
LIMIT = 50

for x1 in (0..LIMIT)
  puts "x1: #{x1}"
  for y1 in (0..LIMIT)
    next if x1 == 0 and y1 == 0

    for x2 in (0..LIMIT)
      next if x1 == 0 and x2 == 0

      for y2 in (0..LIMIT)
        next if x1 == x2 and y1 == y2

        yes = is_right_triangle(x1, y1, x2, y2)
        # puts "(#{x1},#{y1}) - (#{x2},#{y2})#{yes ? "  ---  YES" : ""}"
        count += 1 if yes
      end
    end
  end
end

puts count / 2
