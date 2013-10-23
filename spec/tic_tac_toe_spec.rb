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
      it 'when the board is empty' do
        board.empty?
        space = board.space(row: 2, column: 2)
        expect(strategy.next_move).to eq(space)
      end
    end


  end

end
