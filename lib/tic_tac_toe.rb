class TicTacToe
  class Board
    Space = Struct.new(:column, :row) do

    end
    WIDTH  = 3
    HEIGHT = 3
    attr_reader :spaces

    def initialize
      @spaces = []
      1.upto(HEIGHT) do |row|
        1.upto(WIDTH) do |column|
          spaces << Space.new(column, row)
        end
      end
    end

    def space(coords)
      row = coords.fetch(:row)
      column = coords.fetch(:column)
      spaces.find{|space| space.column == column && space.row == row}
    end

  end

  class Strategy

    def initialize(board)
      @board = board
    end

  end

  def start
    true
  end

  def board
    Board.new
  end
end
