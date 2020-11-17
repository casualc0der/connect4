class Game
  attr_reader :player1, :player2, :board
  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @board = board

  end

  def check_winner

    # we need a loop here to check the permutations
    discs = board.play_area.values_at(0,1,2,3)

    # how many discs in the slice
    number_of_discs = discs.compact.length

    # not enough discs in the slice to confirm a winner
    return false if number_of_discs < 4

    # the slice must all be one colour to declare a winner
    return false if discs.uniq.length > 1

    return discs

  end
end

require './spec/player_spec'
require './spec/board_spec'

RSpec.describe Game do
  let(:player1) { Player.new('peep1', 'o')}
  let(:player2) { Player.new('peep2', 'x')}
  let(:board) { Board.new }
  let(:game) { Game.new(player1, player2, board)}

  describe 'initialization' do
    context 'when first created' do
      it 'should have 2 players and a board' do
        expect { Game.new }.to raise_error(ArgumentError)
        expect { Game.new(player1) }.to raise_error(ArgumentError)
        expect { Game.new(player1, player2) }.to raise_error(ArgumentError)
        expect { Game.new(player1, board) }.to raise_error(ArgumentError)
      end
    end
  end
  describe '#play' do
    pending 'need a way to check for a winner!'
    context 'If player 1 has won' do
      it 'returns player 1'
    end
    context 'If player 2 has won' do
      it 'returns player 2'
    end
    context 'If the game is a draw' do
      it 'returns a draw object'
    end
  end
  describe "#winner" do
    context 'horizontal win for player 1' do
      it 'returns player 1' do
        game.board.insert(1, game.player1.disc)
        game.board.insert(2, game.player1.disc)
        game.board.insert(3, game.player1.disc)
        game.board.insert(4, game.player1.disc)
        expect(game.check_winner).to eq(player1)
      end
    end

  end
end
