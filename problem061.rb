class Fixnum
  def has_cyclic_next?(n)
    self.to_s[2..3] == n.to_s[0..1]
  end
end

class Problem061
  def initialize
    @tried_numbers = {}
  end
  def polygonal
    n = 1
    nums = {}
    loop do
      num = yield(n)
      break if num > 9999
      (nums[num] = true) if num > 1000
      n += 1
    end
    return nums
  end

  def cyclics
    @@_cyclics ||= {
        3 => polygonal{|n| (n*(n+1)) / 2 },
        4 => polygonal{|n| n*n },
        5 => polygonal{|n| (n*(3*n-1))/2 },
        6 => polygonal{|n| n*(2*n-1) },
        7 => polygonal{|n| (n*(5*n-3))/2 },
        8 => polygonal{|n| n*(3*n-2) }
      }
  end

  def pairs_by_cycles(cycles)
    @@_pairs_by_cycles ||= {}
    @@_pairs_by_cycles[cycles.sort.join] ||= begin
        cycles.flat_map do |cycle|
          cyclics[cycle].map{|number, _| [cycle, number] }
        end
      end
  end

  def run
    #pair is [cycle, number]

    all_cycles = cyclics.keys
    all_pairs = pairs_by_cycles(all_cycles)
    all_pairs.each do |cycle1, number1|
      remaining_cycles1 = all_cycles - [cycle1]
      remaining_pairs1 = pairs_by_cycles(remaining_cycles1).select{|p| number1.has_cyclic_next?(p[1]) }

      remaining_pairs1.each do |cycle2, number2|
        remaining_cycles2 = all_cycles - [cycle1, cycle2]
        remaining_pairs2 = pairs_by_cycles(remaining_cycles2).select{|p| number2.has_cyclic_next?(p[1]) }

        remaining_pairs2.each do |cycle3, number3|
          remaining_cycles3 = all_cycles - [cycle1, cycle2, cycle3]
          remaining_pairs3 = pairs_by_cycles(remaining_cycles3).select{|p| number3.has_cyclic_next?(p[1]) }

          remaining_pairs3.each do |cycle4, number4|
            remaining_cycles4 = all_cycles - [cycle1, cycle2, cycle3, cycle4]
            remaining_pairs4 = pairs_by_cycles(remaining_cycles4).select{|p| number4.has_cyclic_next?(p[1]) }

            remaining_pairs4.each do |cycle5, number5|
              remaining_cycles5 = all_cycles - [cycle1, cycle2, cycle3, cycle4, cycle5]
              remaining_pairs5 = pairs_by_cycles(remaining_cycles5).select{|p| number5.has_cyclic_next?(p[1]) }

              cycle6, number6 = remaining_pairs5.find{|p| p[1].has_cyclic_next?(number1) }
              if number6
                result = [[cycle1, number1], [cycle2, number2], [cycle3, number3], [cycle4, number4], [cycle5, number5], [cycle6, number6]]
                puts "FOUND: #{result.inspect}"
                puts "SUM: #{result.map{|c, n| n }.inject(&:+)}"
                exit
              end

            end  #cycle5
          end  #cycle4
        end  #cycle3
      end  #cycle2
    end  #cycle1

  end
end

puts Problem061.new.run




