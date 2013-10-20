class TicTacToe
  class Board
    Space = Struct.new(:column, :row) do

      def empty?
        true
      end

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

    def empty?
      spaces.all?(&:empty?)
    end

  end

  class Strategy

    def initialize(board)
      @board = board
    end

    def next_move
      @board.space(row: 2, column: 2)
    end

  end

  def start
    true
  end

  def board
    Board.new
  end
end
