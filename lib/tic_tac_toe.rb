class TicTacToe
  class Board
    Space = Struct.new(:column, :row) do
      DEFAULT = 0

      def empty?
        value == DEFAULT
      end

      def taken?
        not empty?
      end

      def set(value)
        return false unless empty?
        @value = value
        true
      end

      def test_move(value)
        begin
          @value = value
          yield
        ensure
          @value = DEFAULT
        end
      end

      def value
        @value ||= 0
      end

    end
    COLUMNS  = 3
    ROWS = 3
    SpaceSet = Struct.new(:spaces) do
      # WINNING = 2
      # def winning_move?(move)
      #   values.count(move) == WINNING
      # end
      # def winning_move(move)
      #   winning_move?(move) && spaces.find{|space|space.empty?}
      # end
      def score
        values.reduce(&:+)
      end
      private
      def values
        spaces.reject(&:empty?).map(&:value)
      end
    end
    attr_reader :spaces, :winnable_sets

    def initialize
      @spaces = []
      1.upto(ROWS) do |row|
        1.upto(COLUMNS) do |column|
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

    def empty_spaces
      spaces.select(&:empty?)
    end

    def taken_spaces
      spaces.select(&:taken?)
    end

    def corner?(space)
      (top_or_bottom = [1,ROWS].include?(space.row)) &&
        (left_or_right = [1,COLUMNS].include?(space.column))
    end

    def opposite_corner(space)
      coord = ( [1,ROWS] -  [space.row] ).first
      space(row: coord, column: coord)
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

    def next_move(player)
      if @board.empty? # X's first turn
        top_left_space
      elsif (taken_spaces = @board.taken_spaces).count == 1 #O's  first turn
        if @board.corner?(taken_spaces.first)
          center_space
        else
          :unknown
        end
      elsif (taken_spaces = @board.taken_spaces).count == 2 # X's second turn
        players_space = taken_spaces.find{|space|space.value == player}
        opponents_space = (taken_spaces - [players_space]).first
        if players_space == top_left_space && opponents_space == center_space
          @board.opposite_corner(players_space)
        end
      elsif (taken_spaces = @board.taken_spaces).count == 3 # O's second turn
        players_space = taken_spaces.find{|space|space.value == player}
        opponents_spaces = (taken_spaces - [players_space])
        if players_space == center_space &&
          opponents_spaces.all?{|space| @board.corner?(space)}
          @board.space(row: 3, column: 2)
        else
          :unknown
        end
      else
        :not_a_clue
      end
    end

    private

    def top_left_space
      @board.space(row: 1, column: 1)
    end
    def center_space
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
