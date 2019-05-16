class TicTacToe
    def initialize
        puts "Player 1 (X), enter your name:"
        name1 = gets.chomp
        puts "Player 2 (O), enter your name:"
        name2 = gets.chomp
        @player_one = Player.new(name1, "X")
        @player_two = Player.new(name2, "O")
        @board = Board.new
        @board.display_board
        @current_player = @player_one
    end

    def play
        @win = true
        while @win do
            puts "#{@current_player.name}, enter your option(1-9):"
            @option = Integer(gets.chomp)
            if @board.options.include?(@option)
                @board.add_option(@option, @current_player.symbol)
                @current_player.add_choice(@option)
                @board.display_board
            else
                puts "Enter valid point please!"
                next
            end
            if @board.game_over?(@current_player)
                @win = false
            elsif !@board.options.any? {|i| i.is_a?(Integer)}
                break
            else
                switch_player
            end
        end
        if @win == false
            puts "Congratulations, #{@current_player.name}! You are the WINNER!"
        else
            puts "It's a DRAW."
        end
    end
    private def switch_player
        if @current_player == @player_one
            @current_player = @player_two
        else
            @current_player = @player_one
        end
    end
end
class Board
    attr_reader :options
    def initialize
        @options = [1,2,3,4,5,6,7,8,9]
        @endings = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
    end
    def display_board
        puts ""
        puts " #{@options[0]} | #{@options[1]} | #{@options[2]} |"
        puts " #{@options[3]} | #{@options[4]} | #{@options[5]} |"
        puts " #{@options[6]} | #{@options[7]} | #{@options[8]} |"
        puts ""
    end
    def add_option(x, symbol)
        options[x-1] = symbol
    end
    def game_over?(player)
        if player.choices.include?(1) && player.choices.include?(2) && player.choices.include?(3)
            return true
        elsif player.choices.include?(4) && player.choices.include?(5) && player.choices.include?(6)
            return true
        elsif player.choices.include?(7) && player.choices.include?(8) && player.choices.include?(9)
            return true
        elsif player.choices.include?(1) && player.choices.include?(4) && player.choices.include?(7)
            return true
        elsif player.choices.include?(2) && player.choices.include?(5) && player.choices.include?(8)
            return true
        elsif player.choices.include?(3) && player.choices.include?(6) && player.choices.include?(9)
            return true
        elsif player.choices.include?(1) && player.choices.include?(5) && player.choices.include?(9)
            return true
        elsif player.choices.include?(3) && player.choices.include?(5) && player.choices.include?(7)
            return true
        end
        return false
    end
end
class Player
    attr_reader :name, :symbol, :choices
    def initialize(name, symbol)
        @name = name
        @symbol = symbol
        @choices = []
    end
    def add_choice(x)
        @choices << x
        @choices.sort!
    end
end

testGame = TicTacToe.new
testGame.play