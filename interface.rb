require_relative 'game_manager'

class Interface
    attr_reader :gm

    def initialize
        puts "Enter your name"
        name = gets.chomp
        @gm = GameManager.new(name)

        start_game
    end

    def start_game
        gm.start
        play_rounds
    end

    def play_rounds

        begin
            while gm.continue_round?
                show_cards(gm.user_gamer)

                # show quantity of hide robot cards
                print "#{gm.robot.name}'s cards:"
                gm.robot.cards.each { |card| print "*" }
                
                puts "" 
                puts "Enter a number what would you like to do"
                puts "skip your turn - 1"
                puts "take a card - 2"
                puts "show player's cards and finish the game - 3"
                cmd = gets.to_i


                case cmd
                when 1
                    gm.pass
                when 2
                    gm.add_card
                when 3
                    finish_game
                    return
                else
                    raise "Wrong command number"
                end

                if not(gm.continue_round?)
                    break
                end
                gm.play_for_robot

            end

        rescue StandardError => e
            puts "#{e.message.to_s}"
        retry
        end
        
        finish_game
    end

    def finish_game
        gm.finish

        # interface function
        show_results

        # check ability to continue the game (user and robot have enough money to continue) 
        if gm.next_round?
            begin
                puts "Do you want continue the game?"
                puts "Enter 1 - for YES, 2 - for NO"
                cmd = gets.to_i

                case cmd
                when 1
                    gm.current_round += 1
                    start_game
                # exit from program
                when 2
                    return
                else
                    raise "Wrong command number"
                end 
            rescue StandardError => e
                puts e.message.to_s
            retry
            end
        else
            puts "#{winner.name}'s balance is empty. You can start a new game!"
            return
        end
    end
    
    protected

    def show_cards(gamer)
        gamer_cards = gamer.get_state[:cards]

        cards = gamer_cards.map { |card| "#{card.hand}#{card.suit}" }
        print "#{gamer.name}'s cards: "
        puts cards.join(', ')
    end

    def show_results
        user = gm.user_gamer.get_state
        robot = gm.robot.get_state

        puts show_cards(gm.user_gamer)
        puts "points: #{user[:points]}, balance #{user[:balance]}"

        puts show_cards(gm.robot)
        puts "points: #{robot[:points]}, balance #{robot[:balance]}"

        winner = gm.winner

        if (winner)
            puts "#{winner.name} made this round!"
        else puts "It's a draw!"
        end
    end

end