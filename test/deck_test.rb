require 'minitest/autorun'
require 'minitest/pride'
require './lib/deck'
require './lib/card'
require 'pry'

class DeckTest < Minitest::Test

  def test_it_exists
    deck = Deck.new(card)
    assert_instance_of Deck, deck
  end

end
