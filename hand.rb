class Hand
  attr_reader :cards, :points
  attr_writer :cards

  def initialize(card1, card2)
    @cards = []
    @cards.push(card1)
    @cards.push(card2)
  end

  def add_card(card)
    raise "Can't add a cart: gamer already has three cards" if cards.length == 3

    # redefine card value if card hand is Ace
    card.value = clarify_card_value(card)
    cards.push(card)
  end

  def points
    cards.reduce(0) { |acc, card| acc + card.value }
  end

  def empty_cards
    self.cards = []
  end

  protected

  def clarify_card_value(card)
    case card.hand
    when 'Ace'
      if points < 11
        card.value
      else 1
        end
    else
      card.value
    end
  end
end
