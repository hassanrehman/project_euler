require "./utility.rb"
#If the numbers 1 to 5 are written out in words: 
#  one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
#If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
#NOTE: Do not count spaces or hyphens. 
#For example, 342 (three hundred and forty-two) contains 23 letters and 
# 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.

class English
  def initialize
    @units = {}.tap do |a|
      %w(one two three four five six seven eight nine).each_with_index{ |n, i| a[i+1] = n }
    end

    @teens = {}.tap do |a|
      %w(eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen).each_with_index do |n, i|
        a[i + 11] = n
      end
    end

    @tys = {}.tap do |a|
      %w(ten twenty thirty forty fifty sixty seventy eighty ninety).each_with_index{ |n, i| a[i+1] = n }
    end
  end

  #not building generic .. just for 1 to 1000
  def to_eng(n)
    raise "only built for numbers 1 to 1000" if n < 1 or n > 1000
    return "one thousand" if n == 1000

    word_parts = []

    if n >= 100
      #hundreds can ONLY be from 1 to 9
      hundreds = n / 100
      word_parts << "#{@units[hundreds]} hundred"
      n %= 100
    end

    if n > 19 or n == 10
      word_parts << "#{@tys[n/10]} #{@units[n%10]}".strip
    elsif n >= 11
      word_parts << @teens[n]
    elsif n > 0
      word_parts << @units[n]
    end

    return word_parts.join(" and ")
  end

  def letter_count(n)
    word = to_eng(n)
    word.gsub(/[^\w]/, "").length
  end

  def solve
    (1..1000).to_a.map{|a| letter_count(a) }.sum
  end


end

e = English.new
puts e.solve
#puts e.letter_count(342)
# (1..200).each do |n|
#   puts "#{n} -> #{e.to_eng(n).inspect}"
# end
