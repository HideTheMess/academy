require './hand'

class HumanPlayer
  attr_accessor :bankroll, :hand, :fold, :call

  def initialize(player_no)
    @player_no = player_no
    @bankroll = 100
    @hand = nil
    @fold = false
    @call = false
  end

end
