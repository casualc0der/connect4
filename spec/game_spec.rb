class Game
  attr_reader :player1, :player2, :board, :winning_positions
  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @board = board
    @winning_positions = permutations
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

    # if we've got this far then someone has won...
    # if its not player 1, its player 2!

    return player1.disc_check(discs.uniq.first) ? player1 : player2
  end
  def permutations
    wins = []

    # horizontal
    # TODO: -> Refactor this naughty while loop into a for loop
    d,y = 0,0
    while d < 42
      wins << [d, d+1, d+2, d+3]
      d += 1 and y += 1
      d+=3 and y = 0 if y == 4
    end

    # vertical
    7.times do |i|
      (1..3).each {|p| wins << [i, i+(7*p), i+(14*p), i+(21*p)] }
    end

    # diagonal


    wins
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
  describe '#winning permutations' do
    it 'should have 69 entries' do
      pending
      expect(game.winning_positions.length).to eq(69)
    end
  end
  describe "#winner" do
    context 'single player games' do
    context 'horizontal wins for player 1' do
      it 'returns player 1 (basic)' do
        4.times {|i| game.board.insert(i+1, game.player1.disc)}
        expect(game.check_winner).to eq(player1)
      end
      it 'returns player 1 (with offset)' do
        pending
        4.times {|i| game.board.insert(i+2, game.player1.disc)}
        expect(game.check_winner).to eq(player1)
      end
    end
    context 'horizontal wins for player 2' do
      it 'returns player 2' do
        4.times {|i| game.board.insert(i+1, game.player2.disc)}
        expect(game.check_winner).to eq(player2)

      end
    end
    end
    end
end