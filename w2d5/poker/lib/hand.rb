class Hand
  attr_accessor :hand

  def initialize
    @hand = []
  end

  def remove_cards(cards_array)
    @hand.delete_if { |card| cards_array.include?(card) }
  end

  def return_hand(player)
    player.hand = nil
  end

  def sort_by_value
    @hand.sort! { |card1, card2| card1.value <=> card2.value }
  end

  def value

  end

  # Helper methods
  def four_of_a_kind?
    false unless multiples.has_value(4)
    true
  end

  def full_house?
    false unless multiples.has_value(3) && multiples.has_value(2)
  end

  def multiples
    multiples = Hash.new(0)
    @hand.each do |card|
      multiples[card.value] += 1
    end
    multiples
  end

  def royal_flush?
    false unless straight_flush?
    false unless @hand[3].value == 13

    true
  end

  def straight?
    @hand.size.times do |i|
      next if i == @hand.size - 1

      false unless @hand[i].value + 1 == @hand[i + 1].value
    end

    true
  end

  def straight_flush?
    false unless straight? && flush?
    true
  end

  def flush?
    @hand.size.times do |i|
      next if i == @hand.size - 1

      false unless @hand[i].suit == @hand[i + 1].suit
    end

    true
  end


end
