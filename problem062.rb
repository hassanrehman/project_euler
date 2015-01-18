require "./utility.rb"

=begin
The cube, 41063625 (345**3), can be permuted to produce two other cubes: 
56623104 (384**3) and 66430125 (405**3). In fact, 41063625 is the smallest cube which 
has exactly three permutations of its digits which are also cube.

Find the smallest cube for which exactly five permutations of its digits are cube.
=end

#note: use Array#unique_permutation

class P062
  def initialize
    process
  end

  def get_digits(n)
    to_return = []
    loop do 
      to_return << (n%10)
      n /= 10
      break if n == 0
    end
    to_return.reverse!
    return to_return
  end

  def process
    cubes = (10..10_000).to_a.map{|a| a**3 }
    grouped = cubes.group_by{|a| get_digits(a).sort.join }
    puts grouped.select{|k, v| v.count == 5 }.values.flatten.sort.first
  end

end

P062.new
