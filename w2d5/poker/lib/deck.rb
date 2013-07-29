require_relative './card'

class Deck
  attr_reader :deck # Debug

  def initialize
    @deck = create_shuffled_deck
  end

  def create_shuffled_deck
    deck = []

    Card.suits.each do |suit|
      Card.values.each do |value|
        deck << Card.new(suit, value)
      end
    end

    deck.shuffle
  end

  def take(n)
    until @deck.size > n
      # p @deck
      @deck += create_shuffled_deck
      # p @deck
    end

    take = @deck.take(n)
    @deck = @deck.drop(n)
    # p take
    take
  end
end
