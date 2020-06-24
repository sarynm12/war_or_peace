class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(index)
    @cards[index].rank
  end

  def add_card(card)
    @cards << card
  end

  def high_ranks
    @cards.select do |card|
      card.rank >= 11
    end 
  end

end
