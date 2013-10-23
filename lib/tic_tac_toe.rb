class TicTacToe
  class Board
    Space = Struct.new(:column, :row) do

      def empty?
        value == :empty
      end

      def set(value)
        return false unless empty?
        @value = value
        true
      end

      def value
        @value ||= :empty
      end

    end
    WIDTH  = 3
    HEIGHT = 3
    SpaceSet = Struct.new(:spaces) do
      WINNING = 2
      def winning_move?(move)
        values.count(move) == WINNING
      end
      def winning_move(move)
        winning_move?(move) && spaces.find{|space|space.empty?}
      end
      private
      def values
        spaces.reject(&:empty?).map(&:value)
      end
    end
    attr_reader :spaces, :winnable_sets

    def initialize
      @spaces = []
      1.upto(HEIGHT) do |row|
        1.upto(WIDTH) do |column|
          spaces << Space.new(column, row)
        end
      end
      @winnable_sets = [
        [ [1,1], [1,2], [1,3] ],
        [ [2,1], [2,2], [2,3] ],
        [ [3,1], [3,2], [3,3] ],
        [ [1,1], [2,1], [3,1] ],
        [ [1,2], [2,2], [3,2] ],
        [ [1,3], [2,3], [3,3] ],
        [ [1,1], [2,2], [3,3] ],
        [ [1,3], [2,2], [3,1] ]
      ].map do |set|
        SpaceSet.new Array(set.map do |coords|
          space(row: coords[0], column: coords[1])
        end)
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

    def winning_move(player)
      winnable_sets.find do |winnable_set|
        winning_move = winnable_set.winning_move(player)
        break winning_move if winning_move
      end
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
