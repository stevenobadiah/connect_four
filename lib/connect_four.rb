class Player
    attr_reader :name, :symbol

    def initialize(name, symbol)
        @name = name
        @symbol = symbol
    end
end

class Tile
    attr_reader :x_cord, :y_cord
    attr_accessor :value

    def initialize(x_cord, y_cord, value)
        @x_cord = x_cord
        @y_cord = y_cord
        @value = value
    end
end

class Board
    attr_reader :board

    def initialize
        @board = []
        self.create_board
        self.print_board
    end

    def create_board
        (1..8).to_a.each do |x|
            (1..8).to_a.each do |y|
                tile = Tile.new(x, y, '-')
                @board << tile
            end
        end
    end

    def find(x, y)
        @board.each do |tile|
            return tile if tile.x_cord == x && tile.y_cord == y
        end
    end

    def print_board
        separator = '+---+---+---+---+---+---+---+---+'
        puts separator
        1.upto(8) do |x|
            puts "| #{find(1, x).value} | #{find(2, x).value} | #{find(3, x).value} | #{find(4, x).value} | #{find(5, x).value} | #{find(6, x).value} | #{find(7, x).value} | #{find(8, x).value} |"
            puts separator
        end
    end
end

class Game
    @@round = 1

    def play_game
        while true
            if @@round.odd?
                take_turn($player1.symbol)
            else
                take_turn($player2.symbol)
            end
            if self.player_won?
                if @@round.odd?
                    puts "Contratulations #{$player2.name}!"
                else
                    puts "Contratulations #{$player1.name}!"
                end
                exit
            end
        end
    end

    def valid_move?(x)
        if $board.find(x, 1).value != "-" || x < 0 || x > 8
            return false
        else
            return true
        end
    end

    def take_turn(symbol)
        begin
            puts "What x coordinate you want?"
            x = gets.chomp.to_i
            raise if self.valid_move?(x) == false
            @@round += 1

            if $board.find(x, 8).value == "-"
                $board.find(x, 8).value = symbol
                $board.print_board
            else
                1.upto(8) do |i|
                    if $board.find(x, i).value != "-"
                        $board.find(x, i - 1).value = symbol
                        $board.print_board
                        break
                    end
                end
            end
        rescue
            puts "Invalid selection\n\n"
            retry
        end
    end

    def player_won?
        if self.horizontal_check? || self.vertical_check? || self.upwards_diagonal_check? || self.downwards_diagonal_check?
            return true
        end
    end

    def horizontal_check?
        (1..8).to_a.each do |i|
            (1..5).to_a.each do |j|
                unless $board.find(j, i).value == '-'
                    if $board.find(j, i).value == $board.find(j + 1, i).value && $board.find(j, i).value == $board.find(j + 2, i).value && $board.find(j, i).value == $board.find(j + 3, i).value
                        return true
                    end
                end
            end
        end
        return false
    end

    def vertical_check?
        (1..8).to_a.each do |i|
            (1..5).to_a.each do |j|
                unless $board.find(i, j).value == '-'
                    if $board.find(i, j).value == $board.find(i, j + 1).value && $board.find(i, j).value == $board.find(i, j + 2).value && $board.find(i, j).value == $board.find(i, j + 3).value
                        return true
                    end
                end
            end
        end
        return false
    end

    def upwards_diagonal_check?
        (1..5).to_a.each do |i|
            (4..8).to_a.each do |j|
                unless $board.find(i, j).value == '-'
                    if $board.find(i, j).value == $board.find(i + 1, j - 1).value && $board.find(i, j).value == $board.find(i + 2, j - 2).value && $board.find(i, j).value == $board.find(i + 3, j - 3).value
                        return true
                    end
                end
            end
        end
        return false
    end

    def downwards_diagonal_check?
        (4..8).to_a.each do |i|
            (4..8).to_a.each do |j|
                unless $board.find(i, j).value == '-'
                    if $board.find(i, j).value == $board.find(i - 1, j - 1).value && $board.find(i, j).value == $board.find(i - 2, j - 2).value && $board.find(i, j).value == $board.find(i - 3, j - 3).value
                        return true
                    end
                end
            end
        end
        return false
    end
end

$player1 = Player.new('Steven', 'X')
$player2 = Player.new('Lauren', 'O')
$board = Board.new
game = Game.new
game.play_game