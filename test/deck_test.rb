require 'minitest/autorun'
require 'minitest/pride'
require './lib/deck'
require './lib/card'
require './lib/card_generator'
require 'pry'

class DeckTest < Minitest::Test

  def test_it_exists
    card2 = Card.new(:spade, '2', 2)
    card14 = Card.new(:heart, 'Ace', 14)
    card32 = Card.new(:diamond, '6', 6)
    card47 = Card.new(:club, '8', 8)
    card_pile = [card2, card14, card32, card47]
    deck = Deck.new(card_pile)
    assert_instance_of Deck, deck
  end

  def test_it_can_return_rank
    card2 = Card.new(:spade, '2', 2)
    card14 = Card.new(:heart, 'Ace', 14)
    card32 = Card.new(:diamond, '6', 6)
    card47 = Card.new(:club, '8', 8)
    card_pile = [card2, card14, card32, card47]
    deck = Deck.new(card_pile)
    assert_equal 14, deck.rank_of_card_at(1)
  end

  def test_it_can_add_cards
    card2 = Card.new(:spade, '2', 2)
    card14 = Card.new(:heart, 'Ace', 14)
    card32 = Card.new(:diamond, '6', 6)
    card47 = Card.new(:club, '8', 8)
    card24 = Card.new(:heart, 'Jack', 11)
    card8 = Card.new(:spade, '8', 8)
    card_pile = [card2, card14, card32, card47]
    deck = Deck.new(card_pile)
    deck.add_card(card24)
    deck.add_card(card8)
    assert_equal [card2, card14, card32, card47, card24, card8], deck.cards
  end

  def test_it_can_return_high_rank_cards
    card2 = Card.new(:spade, '2', 2)
    card14 = Card.new(:heart, 'Ace', 14)
    card32 = Card.new(:diamond, '6', 6)
    card47 = Card.new(:club, '8', 8)
    card24 = Card.new(:heart, 'Jack', 11)
    card8 = Card.new(:spade, '8', 8)
    card_pile = [card2, card14, card32, card47, card24, card8]
    deck = Deck.new(card_pile)
    assert_equal [card14, card24], deck.high_ranks
  end

end
