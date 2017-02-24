#http://www.onlineconversion.com/roman_numerals_advanced.htm
#for testing the conversions

VALUES = {
  single: { "I" => 1, "V" => 5, "X" => 10, "L" => 50, "C" => 100, "D" => 500, "M" => 1000 }, 
  double: { "IV" => 4, "IX" => 9, "XL" => 40, "XC" => 90, "CD" => 400, "CM" => 900 }
}

class String
  def from_roman
    n = self
    (VALUES[:double].to_a + VALUES[:single].to_a).inject(0) do |result, (s, v)|
      result += (n.scan(s).length * v)
      n = n.gsub( s, "" )
      result
    end
  end
end

class Fixnum
  def to_roman
    n = self
    if n >= 1000 and (th = "#{n}"[0].to_i) > 0
      thr = "M" * th
    end

    if n >= 100 and (h = "#{n}"[-3].to_i) > 0
      hr = if h == 9
          "CM"
        elsif h == 4
          "CD"
        elsif h >= 5
          "D#{"C"*(h-5)}"
        else
          "C"*h
        end
    end

    if n >= 10 and (t = "#{n}"[-2].to_i) > 0
      tr = if t == 9
          "XC"
        elsif t == 4
          "XL"
        elsif t >= 5
          "L#{"X"*(t-5)}"
        else
          "X"*t
        end
    end
    
    if (o = "#{n}"[-1].to_i) > 0
      _or = if o == 9
          "IX"
        elsif o == 4
          "IV"
        elsif o >= 5
          "V#{"I"*(o-5)}"
        else
          "I"*o
        end
    end

    "#{thr}#{hr}#{tr}#{_or}"
  end
end

puts File.readlines("files/P089.txt").map(&:strip).map{|n| n.length - n.from_roman.to_roman.length }.inject(&:+)





