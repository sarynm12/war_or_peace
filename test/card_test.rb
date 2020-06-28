require 'minitest/autorun'
require 'minitest/pride'
require './lib/card'
require './lib/card_generator'


class CardTest < Minitest::Test

  def setup
    card = Card.new(:diamond, 'Queen', 12)
  end

  def test_it_exists
    card = Card.new(:diamond, 'Queen', 12)
    assert_instance_of Card, card
  end

  def test_it_has_readable_attributes
    card = Card.new(:diamond, 'Queen', 12)
    assert_equal :diamond, card.suit
    assert_equal 'Queen', card.value
    assert_equal 12, card.rank
  end

  def test_all_cards_can_be_created

  end

end
