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

end
