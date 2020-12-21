require_relative 'gamer'

class RobotGamer < Gamer
    def add_card(card)
        raise "Can't add a card: points sum is more than 16" if cards.length >= 17
        super(card)
    end

end