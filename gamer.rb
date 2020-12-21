class Gamer
    attr_reader :balance, :points, :cards, :name
    attr_writer :balance, :points

    def initialize(name='Robot', card1, card2)
        @name = name
        @cards = []
        @cards.push(card1)
        @cards.push(card2)
        @balance = 20
    end

    def add_card(card)
        raise "Can't add a cart: gamer already has three cards" if cards.length == 3
        cards.push(card)

        value = card_value(card)
        self.points += value
    end

    def card_value(card)
        case card.hand
        when "Ace"
            if points < 11
                return card.value
            else return 1
            end
        else
            return card.value
        end
    end

    def points
        cards.reduce(0) { |acc, card| acc+card.value }
    end

    def charge_money(count)
        self.balance -= count
        return count
    end

    def put_money(count)
        self.balance += count
        return count
    end

    def get_state
        return { cards: cards, points: points, balance: balance }
    end

    def empty_cards
        self.cards = []
    end

    protected
    attr_writer :cards

end