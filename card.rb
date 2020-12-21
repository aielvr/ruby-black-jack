class Card
  attr_reader :hand, :suit, :value
  attr_writer :value

  SUITS = ['+', '<3', '^', '<>'].freeze
  CARD_HANDS = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace].freeze
  VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11].freeze

  def initialize(hand, suit, value)
    @hand = hand
    @suit = suit
    @value = value
  end
end
