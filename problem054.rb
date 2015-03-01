require "./utility"


=begin
In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:

High Card: Highest value card.
One Pair: Two cards of the same value.
Two Pairs: Two different pairs.
Three of a Kind: Three cards of the same value.
Straight: All cards are consecutive values.
Flush: All cards of the same suit.
Full House: Three of a kind and a pair.
Four of a Kind: Four cards of the same value.
Straight Flush: All cards are consecutive values of same suit.
Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
The cards are valued in the order:
2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

If two players have the same ranked hands then the rank made up of the highest value wins; 
for example, a pair of eights beats a pair of fives (see example 1 below). 

But if two ranks tie, for example, both players have a pair of queens, 
then highest cards in each hand are compared (see example 4 below); 

if the highest cards tie then the next highest cards are compared, and so on.

Consider the following five hands dealt to two players:

Hand    Player 1              Player 2         Winner
1    5H 5C 6S 7S KD         2C 3S 8S 8D TD    Player 2
     Pair of Fives          Pair of Eights    
             
2    5D 8C 9S JS AC         2C 5C 7D 8S QH    Player 1
     Highest card Ace     Highest card Queen    
             
3    2D 9C AS AH AC         3D 6D 7D TD QD    Player 2
     Three Aces           Flush with Diamonds   
             
4    4D 6S 9H QH QC         3D 6D 7H QD QS    Player 1
     Pair of Queens         Pair of Queens    
     Highest card Nine    Highest card Seven    
             
5    2H 2D 4C 4D 4S        3C 3D 3S 9S 9D     Player 1
     Full House              Full House    
     With Three Fours      with Three Threes   
 
The file, poker.txt, contains one-thousand random hands dealt to two players. 
Each line of the file contains ten cards (separated by a single space): 
the first five are Player 1's cards and the last five are Player 2's cards. 

You can assume that all hands are valid (no invalid characters or repeated cards), 
each player's hand is in no specific order, and in each hand there is a clear winner.

How many hands does Player 1 win?
=end

class Card
  VALUES = {"T" => 10, "J" => 11, "Q" => 12, "K" => 13, "A" => 14}

  attr_reader :value, :suite

  def initialize(s)
    t = s.strip.split("").map(&:strip)
    @value = VALUES[t[0]] || t[0].to_i
    @suite = t[1]
    raise "invalid suite: #{@suite}" unless %w(H C S D).include?(@suite)
  end

  def to_s
    "#{VALUES.invert[@value]||@value}#{@suite}"
  end
end

class String
  def to_card
    Card.new(self)
  end
end

class Hand

  #cards are sorted in reverse order: largest => smallest
  attr_reader :cards, :rank, :ranked_cards, :unranked_cards

  #an array of cards
  def initialize(cards)
    raise "a hand should have 5 cards." if cards.length != 5
    @cards = cards.sort_by(&:value).reverse
    @ranked_cards = []
    @unranked_cards = []
    set_rank
  end

  def same_suite?
    @_same_suite ||= (@cards.map(&:suite).uniq.length == 1)
  end

  def consecutive?
    @_consecutive ||= (0...(@cards.length-1)).map{|i| @cards[i].value - @cards[i+1].value }.all?{|a| a == 1 }
  end

  def value_counts
    @_value_counts ||= @cards.group_by(&:value).values.map(&:count)
  end

  def set_rank
    #Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
    if same_suite? && consecutive? && @cards[0].value == Card::VALUES["A"]
      @rank = 10
      @ranked_cards = @cards
      @unranked_cards = []
    # Straight Flush: All cards are consecutive values of same suit.
    elsif same_suite? && consecutive?
      @rank = 9
      @ranked_cards = @cards
      @unranked_cards = []
    # Four of a Kind: Four cards of the same value.
    elsif value_counts.include?(4)
      @rank = 8
      @ranked_cards = @cards.group_by(&:value).select{|k, v| v.count == 4 }.values.first
      @unranked_cards = @cards - @ranked_cards
    # Full House: Three of a kind and a pair.
    elsif value_counts.include?(3) && value_counts.include?(2)
      @rank = 7
      @ranked_cards = @cards.group_by(&:value).select{|k, v| v.count == 3 }.values.first
      @unranked_cards = @cards - @ranked_cards
    # Flush: All cards of the same suit.
    elsif same_suite?
      @rank = 6
      @ranked_cards = @cards
      @unranked_cards = []
    # Straight: All cards are consecutive values.
    elsif consecutive?
      @rank = 5
      @ranked_cards = @cards
      @unranked_cards = []
    # Three of a Kind: Three cards of the same value.
    elsif value_counts.include?(3)
      @rank = 4
      @ranked_cards = @cards.group_by(&:value).select{|k, v| v.count == 3 }.values.first
      @unranked_cards = @cards - @ranked_cards
    # Two Pairs: Two different pairs.
    elsif value_counts.count(2) == 2
      @rank = 3
      @ranked_cards = @cards.group_by(&:value).values.select{|a| a.count == 2 }.flatten
      @unranked_cards = @cards - @ranked_cards
    # One Pair: Two cards of the same value.
    elsif value_counts.include?(2)
      @rank = 2
      @ranked_cards = @cards.group_by(&:value).select{|k, v| v.count == 2 }.values.first
      @unranked_cards = @cards - @ranked_cards
    else
      @rank = 1
      @ranked_cards = @cards
      @unranked_cards = []
    end
    @ranked_cards = @ranked_cards.sort_by(&:value).reverse
    @unranked_cards = @unranked_cards.sort_by(&:value).reverse

  end

  #return 1 if self wins
  #return -1 if against wins
  #return 0 if draw or cards don't exist
  def compare_cards(against, fn)
    mine = self.send(fn)
    his = against.send(fn)

    return 0 if mine.length == 0 or his.length == 0
    raise "invalid number of cards. self: #{mine.length}, against: #{his.length}" if mine.length != his.length

    mine.zip(his).each do |me, him|
      return 1 if me.value > him.value
      return -1 if me.value < him.value
    end
    return 0
  end

  def compare_ranked_cards(against)
    compare_cards(against, :ranked_cards)
  end
  def compare_unranked_cards(against)
    compare_cards(against, :unranked_cards)
  end

  #return 1 if self wins
  #return -1 if against wins
  #return 0 if draw
  def compare_to(against)
    return 1 if self.rank > against.rank
    return -1 if self.rank < against.rank

    if (value = compare_ranked_cards(against)) != 0
      return value
    end
    
    if (value = compare_unranked_cards(against)) != 0
      return value
    end

    #puts "#{self.cards.inspect} vs #{against.cards.inspect} rank: #{self.rank}"

    return 0
  end

  def wins?(against)
    compare_to(against) == 1
  end

  def to_s
    @cards.map(&:to_s).join(" ")
  end

end


player1_count = 0
File.read("./files/P054.txt").split("\n").each do |line|
  cards = line.split(" ").map(&:strip).map(&:to_card)
  player1_count += 1 if Hand.new(cards[0..4]).wins?(Hand.new(cards[5..-1]))
end

puts player1_count