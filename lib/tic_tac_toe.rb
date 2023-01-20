require 'pry'
class TicTacToe

    attr_accessor :board

    WIN_COMBINATIONS = [
        # Top Row
        [0, 1, 2], 
        # Middle Row
        [3, 4, 5],
        # Bottom Row
        [6, 7, 8],
        # Left Column
        [0, 3, 6],
        # Middle Column
        [1, 4, 7],
        # Right Column
        [2, 5, 8],
        # bL to tR diagonal
        [6, 4, 2],
        # br to tL diagonal
        [0, 4, 8]
    ]
    def initialize board = [" ", " ", " ", " ", " ", " ", " ", " ", " ",]
        @board = board
    end


    def display_board
        board = self.board
        board_arr = []
        n = 0
        while n < 7 do
            board_arr << " #{board[n]} | #{board[n+1]} | #{board[n+2]} "
            board_arr << "-----------"
            n+= 3
        end
        puts board_arr
    end

    def input_to_index str
        str.to_i - 1
    end

    def move index, token = "X"
        self.board[index] = token
    end

    def position_taken? index
        !(self.board[index] == " ")
    end

    def valid_move? index
        !self.position_taken?(index) && index <= 8 && index >= 0
    end

    def turn_count
        count = 0
        self.board.each do |space|
            if space == "X" || space == "O"
                count+= 1
            end
        end
        count
    end

    def current_player
        return "X" if self.turn_count.even?
        return "O"
    end

    def turn input = gets
        # Ask the user for their move by specifying a position between 1-9.
        # Receive the user's input.
        # Translate that input into an index value.
        index = input_to_index(input)
        # If the move is valid, make the move and display the board.
        if valid_move?(index)
            self.move(index, self.current_player)
            self.display_board
        else
            puts "invalid, enter a number between 1-9"
            self.turn
        end
    end

    def won?
        WIN_COMBINATIONS.each do |combination|
            if (self.board[combination[0]] == "X" && self.board[combination[1]] == "X" && self.board[combination[2]] == "X") || (self.board[combination[0]] == "O" && self.board[combination[1]] == "O" && self.board[combination[2]] == "O")
                return combination
            end
        end
        return false
    end

    def full?
        !self.board.include?(" ")
    end

    def draw?
        return false if self.won?
        return true  if self.full?
        false
    end

    def over?
        return true if self.draw?
        return true if self.won?
        false
    end

    def winner
        if self.won? && self.current_player == "X"
            return "O"
        elsif self.won? && self.current_player == "O"
            return "X"
        end
        nil
    end

    def play
        until self.over?
            self.turn
        end

        if self.won?
            puts "Congratulations #{self.winner}!"

        elsif self.draw?
            puts "Cat's Game!"
        end
    end

end

# binding.pry
