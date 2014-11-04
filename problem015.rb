require "./utility"

=begin
for a 2x2 grid ... paths are:
1. RRDD
2. RDRD
3. RDDR
4. DRRD
5. DRDR
6. DDRR

We can repeat this for 3x3 to check as well. Basically its a way 2Rs and 2Ds can be arranged.
So that's basically 4C2 .. or for 3x3 its 6C3

moving on for a 20x20 that's 40C20 .. easy enug
=end

def nCr(n, r)
  n.factorial / (r.factorial * (n-r).factorial)
end

puts nCr(40, 20)