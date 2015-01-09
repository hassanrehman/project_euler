require "./utility.rb"

=begin
The first known prime found to exceed one million digits was discovered in 1999, 
and is a Mersenne prime of the form 2**6972593−1; it contains exactly 2,098,960 digits. 
Subsequently other Mersenne primes, of the form 2**p−1, have been found which contain more digits.

However, in 2004 there was found a massive non-Mersenne prime which contains 2,357,207 digits: 28433 * 2**7830457+1.

Find the last ten digits of this prime number.
=end

#from http://stackoverflow.com/questions/14785329/efficient-way-to-power-and-mod-in-ruby
#require 'openssl'
#puts (28433 * 2.to_bn.mod_exp(7830457, 10**10) + 1).to_s[-10..-1]
puts (28433 * mod_pow(2, 7830457, 10**10) + 1).to_s[-10..-1]