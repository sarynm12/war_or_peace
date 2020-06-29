require 'minitest/autorun'
require 'minitest/pride'
require './lib/turn'
require './lib/player'
require './lib/deck'
require './lib/card'
require './lib/card_generator'

class TurnTest < Minitest::Test

  def test_it_exists
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card1, card2, card5, card8])
    deck2 = Deck.new([card3, card4, card6, card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    assert_instance_of Turn, turn
  end

  def test_it_has_players
    card1 = Card.new(:heart, 'Jack', 11)
    card2 = Card.new(:heart, '10', 10)
    card3 = Card.new(:heart, '9', 9)
    card4 = Card.new(:diamond, 'Jack', 11)
    card5 = Card.new(:heart, '8', 8)
    card6 = Card.new(:diamond, 'Queen', 12)
    card7 = Card.new(:heart, '3', 3)
    card8 = Card.new(:diamond, '2', 2)
    deck1 = Deck.new([card1, card2, card5, card8])
    deck2 = Deck.new([card3, card4, card6, card7])
    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)
    turn = Turn.new(player1, player2)
    assert_equal player1, turn.player1
    assert_equal player2, turn.player2
  end

end

# The Turn is responsible for much of the logic of the game and will respond to the following methods:
#
# initialize: A Turn is created with two players - player1 and player2
# readable attributes for player1, player2, and spoils_of_war
# type: a turn is :basic, :war, or :mutually_assured_destruction.
# A :basic turn is one in which the rank_of_card_at(0) from the players’ decks are not the same rank.
# A :war turn occurs when both players’ rank_of_card_at(0) are the same.
# :mutually_assured_destruction occurs when both players’ rank_of_card_at(0) AND rank_of_card_at(2) are the same.
# winner: this method will determine the winner of the turn.
# if the turn has a type of :basic, it will return whichever player has a higher rank_of_card_at(0)
# if the turn has a type of :war the winner will be whichever player has a higher rank_of_card_at(2)
# if the turn has a type of :mutually_assured_destruction the method will return No Winner.
# pile_cards: when this method is called, cards will be sent from the players’ decks into the @spoils_of_war based on these rules
# for a :basic turn, each player will send one card (the top card) to the spoils pile
# for a :war turn, each player will send three cards (the top three cards) to the spoils pile
# for a :mutually_assured_destruction turn, each player will remove three cards from play (the top three cards in their deck). These cards are not sent to the spoils pile, they are simply removed from each players’ deck.
# award_spoils: this method will add each of the cards in the @spoils_of_war array to the winner of the turn.
# The three interaction patterns below highlight the behavior of each type of turn.
#
# #turn type :basic
# pry(main)> require './lib/card'
# #=> true
# pry(main)> require './lib/deck'
# #=> true
# pry(main)> require './lib/player'
# #=> true
# pry(main)> require './lib/turn'
# #=> true
#
# pry(main)> card1 = Card.new(:heart, 'Jack', 11)
# #=> #<Card:0x007fa3edaa0df0 @rank=11, @suit=:heart, @value="Jack">
# pry(main)> card2 = Card.new(:heart, '10', 10)
# #=> #<Card:0x007fa3eda519a8 @rank=10, @suit=:heart, @value="10">
# pry(main)> card3 = Card.new(:heart, '9', 9)
# #=> #<Card:0x007fa3ed98d9b8 @rank=9, @suit=:heart, @value="9">
# pry(main)> card4 = Card.new(:diamond, 'Jack', 11)
# #=> #<Card:0x007fa3ee14ef80 @rank=11, @suit=:diamond, @value="Jack">
# pry(main)> card5 = Card.new(:heart, '8', 8)
# #=> #<Card:0x007fa3edb263d8 @rank=8, @suit=:heart, @value="8">
# pry(main)> card6 = Card.new(:diamond, 'Queen', 12)
# #=> #<Card:0x007fa3eda3e1f0 @rank=12, @suit=:diamond, @value="Queen">
# pry(main)> card7 = Card.new(:heart, '3', 3)
# #=> #<Card:0x007fa3edad1cc0 @rank=3, @suit=:heart, @value="3">
# pry(main)> card8 = Card.new(:diamond, '2', 2)
# #=> #<Card:0x007fa3eda89308 @rank=2, @suit=:diamond, @value="2">
#
# pry(main)> deck1 = Deck.new([card1, card2, card5, card8])
# #=> #<Deck:0x007fa3eda472c8 @cards=[#<Card:0x007fa3edaa0df0...>, #<Card:0x007fa3eda519a8...>, #<Card:0x007fa3edb263d8...>, #<Card:0x007fa3eda89308...>]>
#
# pry(main)> deck2 = Deck.new([card3, card4, card6, card7])
# #=> #<Deck:0x007fa3ee11ee48 @cards=[#<Card:0x007fa3ed98d9b8...>, #<Card:0x007fa3ee14ef80...>, #<Card:0x007fa3eda3e1f0...>, #<Card:0x007fa3edad1cc0...>]>
#
# pry(main)> player1 = Player.new("Megan", deck1)
# #=> #<Player:0x007fa3edae29d0 @deck=#<Deck:0x007fa3eda472c8...>, @name="Megan">
#
# pry(main)> player2 = Player.new("Aurora", deck2)
# #=> #<Player:0x007fa3ed9e6568 @deck=#<Deck:0x007fa3ee11ee48...>, @name="Aurora">
#
# pry(main)> turn = Turn.new(player1, player2)
# #=> #<Turn:0x007fa3edb25d20 @player1=#<Player:0x007fa3edae29d0..., @name="Megan">, @player2=#<Player:0x007fa3ed9e6568..., @name="Aurora">, @spoils_of_war=[]>
#
# pry(main)> turn.player1
# #=> #<Player:0x007fa3edae29d0 @deck=#<Deck:0x007fa3eda472c8...>, @name="Megan">
#
# pry(main)> turn.player2
# #=> #<Player:0x007fa3ed9e6568 @deck=#<Deck:0x007fa3ee11ee48...>, @name="Aurora">
#
# pry(main)> turn.spoils_of_war
# #=> []
#
# pry(main)> turn.type
# #=> :basic
#
# pry(main)> winner = turn.winner
# #=> #<Player:0x007fa3edae29d0 @deck=#<Deck:0x007fa3eda472c8...>, @name="Megan">
#
# pry(main)> turn.pile_cards
#
# pry(main)> turn.spoils_of_war
# #=> [#<Card:0x007fa3edaa0df0 @rank=11, @suit=:heart, @value="Jack">, #<Card:0x007fa3ed98d9b8 @rank=9, @suit=:heart, @value="9">]
#
# pry(main)> turn.award_spoils(winner)
#
# pry(main)> player1.deck
# #=> #<Deck:0x007fa3eda472c8 @cards=[#<Card:0x007fa3eda519a8...>, #<Card:0x007fa3edb263d8...>, #<Card:0x007fa3eda89308...>, #<Card:0x007fa3edaa0df0...>, #<Card:0x007fa3ed98d9b8...>]>
# pry(main)> player2.deck
# #=> #<Deck:0x007fa3ee11ee48 @cards=[#<Card:0x007fa3ee14ef80...>, #<Card:0x007fa3eda3e1f0...>, #<Card:0x007fa3edad1cc0...>]>
