class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def rank_of_card_at(index)
    @cards[index].rank
  end

  def add_card(card)
    @cards.insert(0, card)
  end

  def high_ranks
    @cards.select do |card|
      card.rank >= 11
    end
  end

  def percent_high_ranks
    percent = (high_ranks.count.to_f / @cards.length.to_f) * 100
    percent.to_f.round(2)
  end

  def remove_card
    @cards.pop
  end

end
