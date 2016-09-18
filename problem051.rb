require 'prime'

class P

  def initialize
    @all_primes = {}
  end

  def is_prime?(p)
    if @all_primes[p]
      is_it = true
    else
      @all_primes[p] = is_it = Prime.prime?(p)
    end
    return is_it
  end

  #returns all binary combinations of +length+
  #starting from 1
  #because of the problem at hand, all the combinations ending with 1, or starting with 0 are removed
  #
  #if ending 1 is used .. then 5 combinations will be even numbers 
  #if combination starting with 0 is used, same digit numbers might not be used
  def binary_combinations(length)
    return [] if length == 1
    return ["10"] if length == 2

    @_binary_combinations_cache ||= {}
    @_binary_combinations_cache[length] ||= begin
        ( 2..(("1"*length).to_i(2)) ).step(2).map{|i| i.to_s(2).rjust(length, "0") }
      end
  end

  #returns all chains of number where binary_string has 1s
  #note the length of all numbers returning has to be equal
  def get_chain(number, binary_string)
    number_array = number.to_s.split("")
    binary_array = binary_string.split("")
    (0..9).map do |it|
      binary_array.map.each_with_index{|b, i| b == "1" ? it : number_array[i] }.join
    end.reject{|n| n[0] == "0" }.map(&:to_i)
  end

  #only returns chains that have all primary numbers (and atleast 2)
  def get_primary_chains(p)
    chains = []
    binary_combinations(p.to_s.length).each do |binary_string|
      chain = get_chain(p, binary_string).select{|n| is_prime?(n) }
      if chain.length > 2
        chains << chain
      end
    end
    return chains
  end

  def process
    Prime.each do |p|
      #if exists in repository .. means its already been checked for all number of families
      next if @all_primes[p]

      chains = get_primary_chains(p)
      if (good_chains = chains.select{|c| c.length == 8 }).length > 0
        puts "found chains: "
        puts good_chains.map(&:inspect)
        puts "min: #{good_chains.flatten.min}"
        break
      end
      
    end
  end

end

P.new.process




