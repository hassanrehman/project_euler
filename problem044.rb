require "./utility.rb"

=begin
Pentagonal numbers are generated by the formula, Pn=n(3n−1)/2. The first ten pentagonal numbers are:

1, 5, 12, 22, 35, 51, 70, 92, 117, 145, ...

It can be seen that P4 + P7 = 22 + 70 = 92 = P8. However, their difference, 70 − 22 = 48, is not pentagonal.

Find the pair of pentagonal numbers, Pj and Pk, for which their sum and difference are pentagonal and D = |Pk − Pj| is minimised; what is the value of D?
=end


THRESHOLD = (10**-6).to_f
class Fixnum
  def p
    self*(3*self - 1) / 2
  end

  def is_p?
    result = (1 + Math.sqrt(1 + 24*self))/6
    (result - result.to_i) < THRESHOLD
  end
end

i = 5
found = false
loop do 
  j = i - 1
  pi = i.p
  loop do 
    pj = j.p
    if (pi - pj).is_p? and (pi + pj).is_p?
      #puts "i: #{i}, pi: #{pi}, j: #{j}, pj: #{pj}, diff: #{pj - pi}"
      puts pi - pj
      found = true
    end
    j -= 1
    break if j == 0
  end
  break if found
  i += 1
end
