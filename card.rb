class Card

    attr_reader :hand, :suit, :value

    def initialize(hand, suit, value)
        @hand = hand
        @suit = suit
        @value = value
    end

end