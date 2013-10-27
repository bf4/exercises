require 'spec_helper'
require 'tic_tac_toe'

describe TicTacToe do
  example do
    TicTacToe
  end

  let(:game) { TicTacToe.new }

  it "can start a game" do
    expect(game.start).to be_true
  end

  it "has a board" do
    expect(game.board).to be_a(TicTacToe::Board)
  end

  describe TicTacToe::Board do

    let(:board) { TicTacToe::Board.new }

    example do
      board
    end

    it 'has 9 spaces' do
      expect(board.spaces.size).to eq(9)
    end

    it 'returns a space for a row and column' do
      row = 1
      column = 3
      space = board.space(row: row, column: column)
      expect(space.row).to    eq(row)
      expect(space.column).to eq(column)
    end

    it 'the board has a set of winning space set combinations' do
      winnable_sets = board.winnable_sets
      expect(winnable_sets.size).to eq(8)
      expect(winnable_sets.first.spaces.first).to eq(board.space(row: 1, column: 1))
    end

    it 'the board can return a winning space set' do
      board.space(row: 1, column: 1).set('x')
      board.space(row: 3, column: 3).set('x')
      expect(board.winning_move('x')).to eq(board.space(row: 2, column: 2))
    end

    describe TicTacToe::Board::Space do
      let(:column) { 1 }
      let(:row)    { 3 }
      let(:space)  { TicTacToe::Board::Space.new(column, row) }
      example do
        expect(space.column).to   eq(column)
        expect(space.row).to      eq(row)
        expect(space.value).to    eq(:empty)
      end
      it 'can act on an empty space' do
        expect(space).to be_empty
        space.set('x')
        expect(space.value).to eq('x')
      end
      it 'can act on an empty space' do
        space.set('x')
        expect(space.set('y')).to be_false
      end
    end

    describe TicTacToe::Board::SpaceSet do
      let(:space_set) do
        TicTacToe::Board::SpaceSet.new(
          [[1,1], [1,2], [1,3]].map do |column_row|
          TicTacToe::Board::Space.new(*column_row)
        end)
      end
      it 'contains an array of spaces' do
        expect(space_set.spaces.size).to eq(3)
      end
      it 'tells if there is a winning move' do
        space_set.spaces[0..1].each do |space|
          space.set('x')
        end
        expect(space_set.winning_move?('x')).to be_true
        expect(space_set.winning_move?('o')).to be_false
      end
      it 'returns the winning space' do
        space_set.spaces[0..1].each do |space|
          space.set('x')
        end
        winning_move = space_set.winning_move('x')
        expect(winning_move.row).to eq(3)
        expect(winning_move.column).to eq(1)
      end

    end

  end

  describe TicTacToe::Strategy do
    let(:board)    { TicTacToe::Board.new }
    let(:strategy) { TicTacToe::Strategy.new(board) }
    example do
      strategy
    end
    context 'determines the next move' do
      context 'on the first turn' do
      it 'X: the board is empty; take a corner' do
        expect(board).to be_empty
        space = board.space(row: 1, column: 1)
        expect(strategy.next_move('x')).to eq(space)
      end
      it "O: when only a corner is taken, take the center" do
        expect(board).to be_empty
        expect(board.space(row: 1, column: 1).set('x')).to be_true
        space = board.space(row: 2, column: 2)
        expect(strategy.next_move('o')).to eq(space)
      end
    end
      context 'on the second turn' do
        it 'X: when O has the middle, take the opposite corner' do
          expect(board).to be_empty
          expect(board.space(row: 1, column: 1).set('x')).to be_true
          expect(board.space(row: 2, column: 2).set('o')).to be_true
          space = board.space(row: 3, column: 3)
          expect(strategy.next_move('x')).to eq(space)
        end

        it 'O: when X has opposite corners, take a middle edge' do
          expect(board).to be_empty
          expect(board.space(row: 1, column: 1).set('x')).to be_true
          expect(board.space(row: 2, column: 2).set('o')).to be_true
          expect(board.space(row: 3, column: 3).set('x')).to be_true

          expect(strategy.next_move('o')).to eq(board.space(row: 3, column: 2))
        end

      end
      context 'on the third turn' do
        

      end
    end

    # count: win in one move? -> win
    # count: win in two moves with one space?  -> fork -> win
    # count: win in three moves with one space? ->

def diagonals(board)
  Matrix.Raise ErrDimensionMismatch unless board.square?
  lower_bound = 0
  upper_bound = board.column_size - 1
  [0, upper_bound].map do |offset|
    Vector.elements((0..upper_bound).map do |i|
      column = offset.zero? ? i : offset - i
      board[i, column]
    end)
  end
end
def sum_vector(vector)
  vector.to_a.reduce(&:+)
end
# not as immutable as you'd think
def play(board, player, row, column)
  board.send(:[]=, row, column, player)
end
    it 'determines the winner' do
      @columns = 3
      @rows = 3
      @default = 0
      @x = 1
      @o = -1
      require 'matrix'
      @board = Matrix.zero(@rows, @columns)
      columns = @board.column_vectors
      rows = @board.row_vectors
      diagonals = diagonals(@board)
      vector_sets = columns + rows + diagonals
      scores = vector_sets.map do |vector|
        sum_vector(vector)
      end
      expect(scores.size).to eq(8)
      expect(scores.uniq.first).to eq(0)
      play(@board, @x,0,0)
      expect(sum_vector(@board.column(0))).to eq(1)
      play(@board, @x,1,0)
      play(@board, @x,2,0)
      winner = vector_sets.find{|vector| sum_vector(vector) == 3}
      expect(winner).to be_nil
    end

  end

end
