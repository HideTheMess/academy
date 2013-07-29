require './dealer'
require './human_player'

class Poker
  def initialize
    @dealer = Dealer.new
    @players = []
  end

  def play
    2.times { |i| @players = HumanPlayer.new(i + 1) }

    # Each round
    loop do
      # Dealer collects ante from each player
      @players.each do |player|
        begin
          @dealer.take_ante(player)
        rescue RuntimeError
          @players.delete(player)
        end
      end
        # Anyone who can't pay ante is out of the game
      # Dealer gives each player 5 cards in hand
      # Each player looks at his/her hand
      # Each player can call, raise, or fold
        # Anyone who folds is out of the round
        # Raise or Call, must add to the pot up to the current bet amount
        # Raise: increases bet, must add to the pot up to that bet amount
          # All calls riscinded at that time
        # Call: Card switching starts when everyone calls or fold after the last bet
      # Each play may switch up to 3 cards from his/her hand
      # Another round of call, raise, or fold
        # Showdown starts when everyone calls after the last bet
      # Showdown: every hand is evaluated
        # If any hand wins above all, winner takes from pot
        # In case of ties, pot is split amongst winners

      # Players can exit at any time; they forfeit anything already in the pot, and it counts as a fold
    end
  end
end
