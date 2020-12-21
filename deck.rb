require_relative 'card'

class Deck
  SUITS = ['+', '<3', '^', '<>'].freeze
  CARD_HANDS = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11].freeze

  attr_accessor :cards

  def initialize
    @cards = []
    create_deck
  end

  private

  def create_deck
    SUITS.each do |suit|
      CARD_HANDS.each_with_index do |hand, index|
        @cards << Card.new(hand, suit, VALUES[index])
      end
    end
  end
end
