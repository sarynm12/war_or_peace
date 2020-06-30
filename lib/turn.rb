class Turn
  attr_reader :player1, :player2, :spoils_of_war

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) && player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
      :mutually_assured_destruction
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0)
      :war
    elsif player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
      :basic
    end
  end

  def winner
    if type == :basic && player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
      player1
    elsif type == :basic && player2.deck.rank_of_card_at(0) > player1.deck.rank_of_card_at(0)
      player2
    elsif type == :war && player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2)
      player1
    elsif type == :war && player2.deck.rank_of_card_at(2) > player1.deck.rank_of_card_at(2)
      player2
    elsif type == :mutually_assured_destruction
      "No Winner"
    end
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
    elsif type == :war
      @spoils_of_war << player1.deck.cards[0]
      @spoils_of_war << player1.deck.cards[1]
      @spoils_of_war << player1.deck.cards[2]
      @spoils_of_war << player2.deck.cards[0]
      @spoils_of_war << player2.deck.cards[1]
      @spoils_of_war << player2.deck.cards[2]
    elsif type == :mutually_assured_destruction
      3.times do
        player1.deck.remove_card
      end
      3.times do
        player2.deck.remove_card
      end
    end
  end

  def award_spoils
    if winner = player1
      @spoils_of_war.each do |spoils_of_war|
        player1.deck.cards << spoils_of_war
      end
    elsif winner = player2
      @spoils_of_war.each do |spoils_of_war|
        player2.deck.cards << spoils_of_war
      end
    end
  end
  # award_spoils: this method will add each of the cards in the @spoils_of_war array to the winner of the turn.

end
