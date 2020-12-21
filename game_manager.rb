require_relative 'user_gamer'
require_relative 'robot_gamer'
require_relative 'deck'

class GameManager
  attr_reader :current_gamer, :gamers, :bank, :robot, :user_gamer, :deck, :current_round
  attr_writer :current_round

  def initialize(name)
    @deck = Deck.new

    @gamers = []
    @user_gamer = UserGamer.new(name, get_random_card, get_random_card)
    @robot = RobotGamer.new(get_random_card, get_random_card)
    @gamers.push(@user_gamer)
    @gamers.push(@robot)
    @current_round = 1

    @bank = 0
  end

  def start
    next_round_initialize if current_round != 1

    @current_gamer = user_gamer
    self.bank += gamers.reduce(0) { |acc, gamer| acc + gamer.charge_money(10) }
  end

  def get_random_card
    deck.cards.sample
  end

  def play_for_robot
    if robot.points >= 17
      pass
    else
      card = get_random_card
      robot.add_card(card)
    end
  end

  def pass
    change_current_gamer
  end

  def add_card
    card = get_random_card
    current_gamer.add_card(card)
  end

  def change_current_gamer
    self.current_gamer = robot if current_gamer.name == user_gamer.name
    self.current_gamer = user_gamer if current_gamer.name == robot.name
  end

  def empty_bank
    sum = bank
    self.bank = 0
    sum
  end

  # check does user and robot have enough money for next round
  def next_round?
    user_gamer.balance > 0 || robot.balance > 0
  end

  def continue_round?
    cards_quantity = gamers.reduce(0) { |acc, gamer| acc + gamer.cards.length }
    return false if cards_quantity == 6
    true
  end

  def winner
    return user_gamer if robot.points > 21
    return robot if user_gamer.points > 21
    return user_gamer if user_gamer.points > robot.points
    return robot if robot.points > user_gamer.points
    nil
  end

  def loser
    return robot if robot.balance.zero?
    return user_gamer if user_gamer.balance.zero?
  end

  def next_round_initialize
    gamers.each do |gamer|
      gamer.empty_cards
      gamer.add_card get_random_card
      gamer.add_card get_random_card
    end
  end

  def finish
    # if the result isn't a draw
    if winner
      count = empty_bank
      winner.put_money(count)
    end
  end

  protected

  attr_writer :bank, :current_gamer, :bank
end
