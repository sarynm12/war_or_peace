class Card
  attr_reader :suit, :value, :rank

  def initialize(suit, value, rank)
    @suit = suit
    @value = value
    @rank = rank
  end
end

@suit = %w{Spades Hearts Diamonds Clubs}
@value = %w{A 2 3 4 5 6 7 8 9 10 J Q K}
@rank = 1..12
