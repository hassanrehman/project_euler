require "./utility.rb"


def palindrome?(n)
  n.to_s.reverse == n.to_s
end

def is_lychrel?(n)
  50.times do
    return false if palindrome?(n = n + n.to_s.reverse.to_i)
  end
  return true
end

puts (1..9999).count{|n| is_lychrel?(n) }

