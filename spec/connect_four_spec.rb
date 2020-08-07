require './lib/connect_four.rb'

describe Player do
    it "creates a player named Steven with symbol X" do
        player1 = Player.new('Steven', 'X')
        expect(player1.name).to eql('Steven')
    end
end

describe Game do
    describe "#valid_move" do
        it "tests the bounds of the board" do
            $board = Board.new
            game = Game.new
            expect(game.valid_move?(2)).to eql(true)
        end
    end

    describe "#horizontal_check?" do
        it "tests horizontal check" do
            $board = Board.new
            game = Game.new
            $board.find(1, 8).value = "X"
            $board.find(2, 8).value = "X"
            $board.find(3, 8).value = "X"
            $board.find(4, 8).value = "X"
        expect(game.horizontal_check?).to eql(true)
        end
    end

    describe "#vertical_check?" do
        it "tests vertical check" do
            $board = Board.new
            game = Game.new
            $board.find(8, 1).value = "X"
            $board.find(8, 2).value = "X"
            $board.find(8, 3).value = "X"
            $board.find(8, 4).value = "X"
            expect(game.vertical_check?).to eql(true)
        end
    end

    describe "#upwards_diagonal_check?" do
        it "tests upwards_diagonal check" do
            $board = Board.new
            game = Game.new
            $board.find(1, 8).value = "X"
            $board.find(2, 7).value = "X"
            $board.find(3, 6).value = "X"
            $board.find(4, 5).value = "X"
            expect(game.upwards_diagonal_check?).to eql(true)
        end
    end

    describe "#downwards_diagonal_check?" do
        it "tests downwards_diagonal check" do
            $board = Board.new
            game = Game.new
            $board.find(1, 1).value = "X"
            $board.find(2, 2).value = "X"
            $board.find(3, 3).value = "X"
            $board.find(4, 4).value = "X"
            expect(game.downwards_diagonal_check?).to eql(true)
        end
    end
end
