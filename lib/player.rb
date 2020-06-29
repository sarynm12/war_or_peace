class Player
  attr_reader :name, :deck, :lost

  def initialize(name, deck)
    @name = name
    @deck = deck
    @lost = false
  end

  def has_lost?
    if deck.cards.count >= 1
      @lost
    else deck.cards.count < 1
      @lost = true
    end
  end

end
