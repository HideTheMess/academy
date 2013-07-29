require './deck'

class Dealer
  @@ANTE = 1

  def initialize
    @deck = Deck.new
    @bet = 0
    @pot = {}
  end

  def give_cards(player, n)
    take = @deck.take(n)
    player.hand.hand += take
  end

  def give_hand(player)
    player.hand = Hand.new
    give_cards(player, 5)
  end


  def take_ante(player)
    raise "Player #{player.player_no} can't pay ante" \
          if player.bankroll < @@ANTE
    player.bankroll -= @@ANTE
    @pot[player] = @@ANTE
  end


  def take_bets(player)

  end

end
