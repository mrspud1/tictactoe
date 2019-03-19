class Game
    def initialize
        puts "Welcome to tic-tac-toe"
        puts "If you don't know how to play, please type 'rules' otherwise type 'play'."
        good_string = false
        while !good_string
            input = gets.chomp
            if input == "rules"
                rules
                good_string = true
            elsif input == "play"
                start
                good_string = true
            else
                puts "Please type either 'rules' or 'play'"
            end
        end
    end

    def rules
        puts "Rules of tic-tac-toe"
    end

    def start
        puts "Playing against the computer. X's or O's?"
        player_choice

        puts "Game is begining..."
        @game_hash = {}
        for x in 1..9
            @game_hash[x] = "n"
        end
        @game_over = false
        game_loop
    end

    def game_loop
        game_draw
        player_input
        game_status?
        if @game_over
            puts "Would you like to play again? y/n"
            input = gets.chomp
            if input.downcase == "y"
                puts "Playing again."
                start
            else
                puts "Thanks for playing!"
            end
        else
            computer_turn
            game_status?
            if @game_over
                puts "Would you like to play again? y/n"
                input = gets.chomp
                if input.downcase == "y"
                    puts "Playing again."
                    start
                else
                    puts "Thanks for playing!"
                end
            else
                game_loop
            end
        end       
    end

    private
    def player_choice
        good_input = false
        counter = 1
        while !good_input
            input = gets.chomp
            if input.downcase == "x"
                @player = "x"
                @computer = "o"
                good_input = true
            elsif input.downcase == "o"
                @player = "o"
                @computer = "x"
                good_input = true
            else
                if counter < 3
                    puts "Please enter either 'x' or 'o' to indicate your prefered piece."
                    counter += 1
                else
                    puts "You have been automatically assigned 'x'"
                    @player = "x"
                    @computer = "o"
                    good_input = true
                end
            end
        end
    end
    
    def game_draw
        game_array = []
        for x in 1..3
            current = ""
            for y in 1..3
                position = (x - 1) * 3 + y
                if @game_hash[position] != "n"
                    current << " " << @game_hash[position].upcase << " "
                else
                    current << "   "
                end
                unless y % 3 == 0
                    current << "|"
                end
            end
            game_array.push(current)
        end
        puts game_array[0]
        puts "-----------"
        puts game_array[1]
        puts "-----------"
        puts game_array[2]
    end

    def player_input
        puts "Where would you like to play? 1-9"
        good_input = false
        while !good_input
            input = Integer(gets.chomp) rescue false
            unless input && input >= 1 && input <= 9
                puts "Please enter an number from 1 to 9..."
            else
                if @game_hash[input] == "n"
                    @game_hash[input] = @player
                    good_input = true
                else
                    puts "Please pick a cell that hasn't been chosen"
                end
            end
        end
    end

    def game_status?
        #Check for a win/loss
        winning_array = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
        winning_array.each do |x|
            player_counter = 0
            computer_counter = 0
            x.each do |y| 
                player_counter += 1 if @game_hash[y] == @player
                computer_counter += 1 if @game_hash[y] == @computer
            end
            if player_counter == 3
                game_draw
                puts "Well done, you won!"
                @game_over = true
            elsif computer_counter == 3
                game_draw
                puts "The computer won..."
                @game_over = true
            end
        end
        counter = 0
        for x in 1..9
            if @game_hash[x] == "n"
                counter += 1
            end
        end
        if counter == 0
            puts "The game is a draw..."
            @game_over = true
        end
    end

    def computer_turn
        possible_array = []
        for x in 1..9
            if @game_hash[x] == "n"
                possible_array.push(x)
            end
        end
        choice = rand(0..possible_array.length-1)
        @game_hash[possible_array[choice]] = @computer
    end
end

game1 = Game.new