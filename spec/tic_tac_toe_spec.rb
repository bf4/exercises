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

    describe TicTacToe::Board::Space do
      let(:column) { 1 }
      let(:row)    { 3 }
      let(:space)  { TicTacToe::Board::Space.new(column, row) }
      example do
        expect(space.column).to eq(column)
        expect(space.row).to    eq(row)
      end
    end
  end


end
