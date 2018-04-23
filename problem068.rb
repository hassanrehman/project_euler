=begin
  #solution for the example
  max_s = "111;111;111"
  (1..6).to_a.permutation.each do |a|
    
    if ( a[0] < a[3] ) and ( a[0] < a[5] ) and
       ( a[0] + a[1] + a[2] == a[3] + a[2] + a[4] ) and 
       ( a[3] + a[2] + a[4] == a[5] + a[4] + a[1] ) and 
       ( a[5] + a[4] + a[1] == a[0] + a[1] + a[2] )
      s = [[a[0], a[1], a[2]], [a[3], a[2], a[4]], [a[5], a[4], a[1]]].map(&:join).join(";")
      # puts s
      max_s = s if s > max_s
    end

  end
  puts max_s
=end



max_s = (["111"]*5).join("")
(1..10).to_a.permutation.each do |a|
  #since we cannot have 17 digits ... we need to make sure 10 remains counted only once (outer circle)
  if ( a[0] == 10 or a[3] == 10 or a[5] == 10 or a[7] == 10 or a[9] == 10 ) and 
     ( a[0] < a[3] ) and ( a[0] < a[5] ) and ( a[0] < a[7] ) and ( a[0] < a[9] ) and
     ( a[0] + a[1] + a[2] == a[3] + a[2] + a[4] ) and 
     ( a[3] + a[2] + a[4] == a[5] + a[4] + a[6] ) and 
     ( a[5] + a[4] + a[6] == a[7] + a[6] + a[8] ) and
     ( a[7] + a[6] + a[8] == a[9] + a[8] + a[1] ) and
     ( a[9] + a[8] + a[1] == a[0] + a[1] + a[2] )

    s = [
      [ a[0], a[1], a[2] ], [ a[3], a[2], a[4] ], [ a[5], a[4], a[6] ],
      [ a[7], a[6], a[8] ], [ a[9], a[8], a[1] ]
    ].map(&:join).join("")
    # puts s
    max_s = s if s > max_s

  end

end
puts max_s