require_relative 'hand'

class Gamer
  attr_reader :balance, :points, :name
  attr_writer :balance, :points

  def initialize(name = 'Robot', card1, card2)
    @name = name
    @hand = Hand.new(card1, card2)

    @balance = 30
  end

  def cards
    hand.cards
  end

  def add_card(card)
    hand.add_card(card)
  end

  def points
    hand.points
  end

  def charge_money(count)
    self.balance -= count
    count
  end

  def put_money(count)
    self.balance += count
    count
  end

  def get_state
    { cards: cards, points: points, balance: balance }
  end

  def empty_cards
    hand.empty_cards
  end

  protected

  attr_reader :hand
  attr_writer :cards
end
