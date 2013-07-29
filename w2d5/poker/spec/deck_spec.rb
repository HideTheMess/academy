require 'rspec'
require_relative '../lib/deck'

describe Deck do
  let(:deck) { Deck.new }

  describe "#create_shuffled_deck" do
    it "creates a full deck of cards" do
      deck.create_shuffled_deck.size.should == 52
    end

    it "deck is random everytime" do
      deck.create_shuffled_deck[0].value.should_not \
        == deck.create_shuffled_deck[0].value
    end
  end

  describe "#take" do
    it "gives n cards" do
      hand = deck.take(3)
      hand.size.should == 3
    end

    it "removes from deck" do
      hand = deck.take(3)
      deck.deck.size.should == 49
    end

    it "refills the deck if there's not enough cards" do
      hand = deck.take(65)
      deck.deck.size.should == ((52 * 2) - 65)
    end
  end
end

# Hold a deck of cards
# Refill deck when empty / close to empty
# Give n cards