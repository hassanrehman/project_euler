require 'prime'

class Prime
  #http://www.codeproject.com/Articles/691200/Primality-test-algorithms-Prime-test-The-fastest-w
  #not reliable ..... different results in come cases
  def fermat_prime?(n, certainly_value=10)
    return false if n == 1
    return true if n == 2 or n == 3
    certainly_value.times do 
      r = rand(n-1) + 1
      return false if mod_pow(r, n-1, n) != 1
    end
    return true
  end

  #http://www.codeproject.com/Articles/691200/Primality-test-algorithms-Prime-test-The-fastest-w
  def miller_rabin_prime?(number)
    # because the algorithm input is ODD number than if we get
    # even and it is the number 2 we return TRUE ( spcial case )
    # if we get the number 1 we return false and any other even 
    # number we will return false.
    return true if number == 2
    return false if number == 1 or number%2 == 0

    # first we want to express n as : 2^s * r ( where r is odd )
    
    #the odd part of the number
    oddPartOfNumber = number - 1
    
    #The number of time that the number is divided by two
    timesTwoDividNumber = 0
    
    #while r is even divid by 2 to find the odd part
    while oddPartOfNumber % 2 == 0 do
      oddPartOfNumber = oddPartOfNumber / 2
      timesTwoDividNumber += 1 
    end

    # since there are number that are cases of "strong liar" we 
    # need to check more then one number
    3.times do
      #choose "Good" random number
      randomNumber = nil
      loop do
        #Draw a RANDOM number in range of number ( Z_number )
        randomNumber = rand(number-1) + 1
        break if randomNumber != 0 and randomNumber != 1
      end
      #randomNumberWithPower = randomNumber^oddPartOfNumber mod number
      randomNumberWithPower = mod_pow(randomNumber, oddPartOfNumber, number)
      #if random number is not 1 and not -1 ( in mod n )
      if (randomNumberWithPower != 1) and (randomNumberWithPower != number - 1)
        # number of iteration
        iterationNumber = 1
        #while we can squre the number and the squered number is not -1 mod number

        while (iterationNumber <= timesTwoDividNumber - 1) and (randomNumberWithPower != number - 1) do
          #squre the number
          randomNumberWithPower = mod_pow(randomNumberWithPower, 2, number)
          iterationNumber += 1
        end
        # if x != -1 mod number then it because we did not found strong witnesses
        # hence 1 have more then two roots in mod n ==>
        # n is composite ==> return false for primality
        return false if (randomNumberWithPower != (number - 1))

        
      end

    end
    #well the number pass the tests ==> it is probably prime ==> return true for primality
    return true 
  end

end

class Array
  def sum
    self.inject(&:+)
  end
  def multiply
    self.inject(&:*)
  end

  #http://apidock.com/rails/v3.2.3/Array/in_groups_of
  def in_groups_of(number, fill_with = nil)
    if fill_with == false
      collection = self
    else
      # size % number gives how many extra we have;
      # subtracting from number gives how many to add;
      # modulo number ensures we don't add group of just fill.
      padding = (number - size % number) % number
      collection = dup.concat([fill_with] * padding)
    end

    if block_given?
      collection.each_slice(number) { |slice| yield(slice) }
    else
      groups = []
      collection.each_slice(number) { |group| groups << group }
      groups
    end
  end

  #http://apidock.com/rails/ActiveSupport/CoreExtensions/Array/Grouping/in_groups
  def in_groups(number, fill_with = nil)
    # size / number gives minor group size;
    # size % number gives how many objects need extra accomodation;
    # each group hold either division or division + 1 items.
    division = size / number
    modulo = size % number

    # create a new array avoiding dup
    groups = []
    start = 0

    number.times do |index|
      length = division + (modulo > 0 && modulo > index ? 1 : 0)
      padding = fill_with != false &&
        modulo > 0 && length == division ? 1 : 0
      groups << slice(start, length).concat([fill_with] * padding)
      start += length
    end

    if block_given?
      groups.each{|g| yield(g) }
    else
      groups
    end
  end
end

class Fixnum
  def abs
    (self < 0) ? -1*self : self
  end

  def factorial
    return 1 if self == 1 or self == 0
    return 2 if self == 2

    (2..self).inject(&:*)
  end

  #calculates nCr
  def C(r)
    factorial / (r.factorial * (self-r).factorial)
  end
end

class Time
  def elapsed(options={})
    default_options = {
      round_digits: 2
    }
    options = default_options.merge(options)
    elapsed = Time.now - self
    elapsed.round(options[:round_digits])
  end
end

#http://stackoverflow.com/questions/14785329/efficient-way-to-power-and-mod-in-ruby
require 'openssl'
#calculates n**r mod m
def mod_pow(n, r, m)
  n.to_bn.mod_exp(r, m)
end
