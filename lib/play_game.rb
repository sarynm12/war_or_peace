require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class PlayGame

  def start
    suits = [:spade, :heart, :diamond, :club]
    values = ["2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"]
    cards = []
    ranks = (2..14).to_a
    suits.each do |suit|
      complete_cards = ranks.zip(values)
      complete_cards.each do |rank, value|
        cards << Card.new(suit, value, rank)
      end
    end
    shuffled = cards.shuffle!

    deck1 = Deck.new(shuffled.pop(26))
    deck2 = Deck.new(shuffled)

    player1 = Player.new("Megan", deck1)
    player2 = Player.new("Aurora", deck2)

    p "Welcome to War! (or Peace) This game will be played with 52 cards."
    p "The players today are Megan and Aurora."
    p "Type 'GO' to start the game!"
    p "------------------------------------------------------------------"

    input = gets.chomp.upcase
    while input != 'GO'
      p "Please try again. Type 'GO' to start."
      input = gets.chomp.upcase
    end 
    if input == 'GO'
    turn_count = 1

    until (player1.has_lost? || player2.has_lost? || turn_count == 1_000_000) do
      turn = Turn.new(player1, player2)
      puts "Turn Type: #{turn.type}"

      winner = turn.winner
      case turn.type
      when :basic
        turn.pile_cards
        turn.award_spoils(winner)
        p "Turn #{turn_count}: #{winner.name} won 2 cards"

      when :war
        turn.pile_cards
        turn.award_spoils(winner)
        p "Turn#{turn_count}: #{winner.name} won 6 cards."

      when :mutually_assured_destruction
        turn.pile_cards
        p "Turn#{turn_count}: *mutually assured destruction* 6 cards removed from play."
      end
      turn_count += 1

      if player1.has_lost? || player2.has_lost?
        puts "*~*~*~* #{winner.name} has won the game! *~*~*~*"
      elsif turn_count == 1_000_000
        puts "*~*~*~* Game over: it's a DRAW *~*~*~*"
      end
    end
  end
  end
end
