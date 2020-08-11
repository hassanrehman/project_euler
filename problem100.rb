#https://www.alpertron.com.ar/QUAD.HTM
#  2b*b - t*t - 2*b + n = 0
def next_b(b, t)
  3*b + 2*t - 2
end
def next_t(b, t)
  4*b + 3*t - 3
end

def result(b, t)
  2*b*b - t*t - 2*b + t
end

b = 15
t = 21
limit = 10**12
loop do
  puts "b: #{b}, t: #{t}, result: #{result(b, t)}"
  if t > limit
    puts "FINAL: b: #{b}, t: #{t}, result: #{result(b, t)}"
    break
  end
  _b = next_b(b, t)
  _t = next_t(b, t)
  b = _b
  t = _t
end