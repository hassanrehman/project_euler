require './utility.rb'

MAX = 10**7

# phi(n) = n * product(1 - 1/p)
# phi(n) = n * product(p-1 / p)
# n / phi(n) = p**k / (p1 - 1)*(p2 - 1)*(p3 - 1)
#
#the more primes we use .. the numerator will become bigger than denominator
#this means we can only use 2 ... if we use ANY three, it'd be bigger than the two we use
#hence k == 2
#so for our answer:
#phi(n) = n*(p1 - 1)*(p2 - 1) / (p1*p2)
#in our algo, we will use two primes .. so:
#phi(n) = (p1 - 1)*(p2 - 1)
#and n/phi(n) = p1*p2 / (p1 - 1)*(p2 - 1)

#to minimize this .. n/phi .. we need to chose as big primes as we can to stay within limit
#coz the smaller the primes .. the denominator will get more smaller by subtracting 1


first = 2
second = 2
Prime.each do |p|
  second = p
  if (first * second) > MAX
    break
  else
    first = second
  end
end

#so our bound is first
# primes = Prime.each(first).to_a

#after getting wrong answers i realized that larger primes than +first+
#can multiply with some of the slighly smaller ones to make a number < 10**7
#
#by investigation .. first = 3163
# .. so i'd search between like 2k and 6k .. just to be safe .. if this doesn't work .. i'd expand

MIN_PRIME = 2000
MAX_PRIME = 6000

primes = Prime.each(MAX_PRIME).to_a.select{|p| p > MIN_PRIME }

#TODO: this can be improved if too slow
def is_perm(p1, p2)
  p1.to_s.split("").map(&:to_i).sort.join == p2.to_s.split("").map(&:to_i).sort.join
end

smallest = MAX
smallest_n = 0
primes.each_with_index do |p1, i|
  primes[i..-1].each do |p2|
    n = p1 * p2
    next if n > MAX

    phi = (p1 - 1)*(p2 - 1)
    if is_perm(n, phi)
      puts "n: #{n}, phi: #{phi}, smallest_n: #{smallest_n}, ratio: #{smallest}"
      nphi = n / phi.to_f
      if smallest > nphi
        smallest = nphi
        smallest_n = n
      end
    end

  end
end

puts smallest_n









