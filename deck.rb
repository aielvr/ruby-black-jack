require_relative 'card'

class Deck
  attr_accessor :cards

  def initialize
    @cards = []
    create_deck
  end

  private

  def create_deck
    Card::SUITS.each do |suit|
      Card::CARD_HANDS.each_with_index do |hand, index|
        @cards << Card.new(hand, suit, Card::VALUES[index])
      end
    end
  end
end
