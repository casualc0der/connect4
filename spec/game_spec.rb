require_relative '../lib/connect4/player'
require_relative '../lib/connect4/board'
require_relative '../lib/connect4/game'

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

  describe '#winning permutations' do
    context 'in total' do
    it 'should have 69 entries' do
      expect(game.winning_positions.length).to eq(69)
    end
    context '#horizontal (helper)' do
      it 'should return winning horizonal positions' do
        expected  = [[0, 1, 2, 3],
                     [1, 2, 3, 4],
                     [2, 3, 4, 5],
                     [3, 4, 5, 6],
                     [7, 8, 9, 10],
                     [8, 9, 10, 11],
                     [9, 10, 11, 12],
                     [10, 11, 12, 13],
                     [14, 15, 16, 17],
                     [15, 16, 17, 18],
                     [16, 17, 18, 19],
                     [17, 18, 19, 20],
                     [21, 22, 23, 24],
                     [22, 23, 24, 25],
                     [23, 24, 25, 26],
                     [24, 25, 26, 27],
                     [28, 29, 30, 31],
                     [29, 30, 31, 32],
                     [30, 31, 32, 33],
                     [31, 32, 33, 34],
                     [35, 36, 37, 38],
                     [36, 37, 38, 39],
                     [37, 38, 39, 40],
                     [38, 39, 40, 41]]

        expect(game.horizontal).to match_array(expected)
      end

    end
    context '#diagonal (helper)' do
      it 'should return winning diagonal postions' do
        expected = [[0, 8, 16, 24],
                    [1, 9, 17, 25],
                    [2, 10, 18, 26],
                    [3, 11, 19, 27],
                    [3, 9, 15, 21],
                    [4, 10, 16, 22],
                    [5, 11, 17, 23],
                    [6, 12, 18, 24],
                    [7, 15, 23, 31],
                    [8, 16, 24, 32],
                    [9, 17, 25, 33],
                    [10, 18, 26, 34],
                    [10, 16, 22, 28],
                    [11, 17, 23, 29],
                    [12, 18, 24, 30],
                    [13, 19, 25, 31],
                    [14, 22, 30, 38],
                    [15, 21, 27, 33],
                    [16, 24, 32, 40],
                    [17, 25, 33, 41],
                    [17, 23, 29, 35],
                    [18, 24, 30, 36],
                    [19, 25, 31, 37],
                    [20, 26, 32, 38]]

        expect(game.diagonal).to match_array(expected)
        end
    end
    context '#vertical (helper)' do
      it 'should return winning vertical postions' do
        expected =   [[0, 7, 14, 21],
                      [1, 8, 15, 22],
                      [2, 9, 16, 23],
                      [3, 10, 17, 24],
                      [4, 11, 18, 25],
                      [5, 12, 19, 26],
                      [6, 13, 20, 27],
                      [7, 14, 21, 28],
                      [8, 15, 22, 29],
                      [9, 16, 23, 30],
                      [10, 17, 24, 31],
                      [11, 18, 25, 32],
                      [12, 19, 26, 33],
                      [13, 20, 27, 34],
                      [14, 21, 28, 35],
                      [15, 22, 29, 36],
                      [16, 23, 30, 37],
                      [17, 24, 31, 38],
                      [18, 25, 32, 39],
                      [19, 26, 33, 40],
                      [20, 27, 34, 41]]

        expect(game.vertical).to match_array(expected)
      end

    end
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
        4.times {|i| game.board.insert(i+2, game.player1.disc)}
        expect(game.check_winner).to eq(player1)
      end
    end
    context 'horizontal wins for player 2' do
      it 'returns player 2' do
        4.times {|i| game.board.insert(i+1, game.player2.disc)}
        expect(game.check_winner).to eq(player2)

      end
      it 'returns player 2 (with offset)' do
        4.times {|i| game.board.insert(i+2, game.player2.disc)}
        expect(game.check_winner).to eq(player2)
      end
    end
    end

    context 'complex board states do' do
      let(:player1) { Player.new('Edd', 'x')}
      let(:player2) { Player.new('Tom', 'o')}
      let(:selections) { (0..42).to_a }



      context 'horizontal wins for player 1' do
        it 'returns player 1 after 15 turns' do

          play_area = [
              'x', 'o', 'x', 'o', 'x', 'o', 'x',
              'o', 'o', 'x', 'x', 'x', 'x', 'o',
              'o', nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil
          ]


          board = Board.new(play_area, selections)
          game = Game.new(player1, player2, board)

          expect(game.check_winner).to eq(player1)
        end

        it 'returns player 1 after 28 turns' do
          play_area = [
              'x', 'o', 'x', 'o', 'x', 'o', 'x',
              'x', 'x', 'x', 'o', 'o', 'o', 'x',
              'o', 'o', 'o', 'x', 'x', 'x', 'o',
              'x', 'x', 'x', 'x', 'o', 'o', 'o',
              nil, nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil
          ]

          board = Board.new(play_area, selections)
          game = Game.new(player1, player2, board)

          expect(game.check_winner).to eq(player1)
        end
      end
      context 'horizontal wins for player 2' do
        it 'returns player 2 after 15 turns' do

        play_area = [
            'o', 'x', 'o', 'x', 'o', 'x', 'o',
            'x', 'x', 'o', 'o', 'o', 'o', 'x',
            'x', nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil
        ]

        board = Board.new(play_area, selections)
        game = Game.new(player1, player2, board)

        expect(game.check_winner).to eq(player2)

        end

        it 'returns player 2 after 28 turns' do
          play_area = [
              'o', 'x', 'o', 'x', 'o', 'x', 'o',
              'o', 'o', 'o', 'x', 'x', 'x', 'o',
              'x', 'x', 'x', 'o', 'o', 'o', 'x',
              'o', 'o', 'o', 'o', 'x', 'x', 'x',
              nil, nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil
          ]

          board = Board.new(play_area, selections)
          game = Game.new(player1, player2, board)

          expect(game.check_winner).to eq(player2)


        end


      end

      context 'vertical wins for player 1' do
        it 'returns player 1 after 15 turns' do

          play_area = [
              'x', 'o', 'x', 'o', 'x', 'o', 'x',
              'x', 'o', 'o', 'x', nil, 'o', 'o',
              'x', nil, nil, nil, nil, nil, nil,
              'x', nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil
          ]

          board = Board.new(play_area, selections)
          game = Game.new(player1, player2, board)

          expect(game.check_winner).to eq(player1)
        end
        it 'returns player 1 after 28 turns' do
          play_area = [
              'o', 'o', 'x', 'x', 'x', 'o', 'x',
              'o', 'x', 'x', 'x', 'o', 'o', 'x',
              'x', 'o', 'o', 'x', 'x', 'x', 'o',
              'x', 'x', 'o', 'x', 'o', 'o', 'o',
              nil, nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil
          ]

          board = Board.new(play_area, selections)
          game = Game.new(player1, player2, board)

          expect(game.check_winner).to eq(player1)
        end



      end
      context 'vertical wins for player 2' do
        it 'returns player 2 after 15 turns' do

          play_area = [
              'o', 'x', 'o', 'x', 'o', 'x', 'o',
              'o', 'x', 'x', 'o', nil, 'x', 'x',
              'o', nil, nil, nil, nil, nil, nil,
              'o', nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil
          ]

          board = Board.new(play_area, selections)
          game = Game.new(player1, player2, board)

          expect(game.check_winner).to eq(player2)
        end
        it 'returns player 2 after 28 turns' do
          play_area = [
              'x', 'x', 'o', 'o', 'o', 'x', 'o',
              'x', 'o', 'o', 'o', 'x', 'x', 'o',
              'o', 'x', 'x', 'o', 'o', 'o', 'x',
              'o', 'o', 'x', 'o', 'x', 'x', 'x',
              nil, nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil
          ]

          board = Board.new(play_area, selections)
          game = Game.new(player1, player2, board)

          expect(game.check_winner).to eq(player2)
        end
      end

      context 'diagonal wins for player 1' do
        it 'returns player 1 after 16 turns' do

          play_area = [
              'x', 'o', 'o', 'x', 'x', 'o', 'o',
              'x', 'o', 'x', 'x', nil, 'o', 'o',
              'o', 'x', nil, nil, nil, nil, nil,
              'x', nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil
          ]

          board = Board.new(play_area, selections)
          game = Game.new(player1, player2, board)

          expect(game.check_winner).to eq(player1)
        end
        it 'returns player 1 after 28 turns' do
          play_area = [
              'o', 'o', 'x', 'x', 'x', 'o', 'x',
              'o', 'x', 'x', 'o', 'o', 'x', 'x',
              'x', 'o', 'o', 'x', 'x', 'x', 'o',
              'x', 'x', 'o', 'x', 'o', 'o', 'o',
              nil, nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil
          ]

          board = Board.new(play_area, selections)
          game = Game.new(player1, player2, board)

          expect(game.check_winner).to eq(player1)
        end
      end

      context 'diagonal wins for player 2' do
        it 'returns player 2 after 16 turns' do

          play_area = [
              'o', 'x', 'x', 'o', 'o', 'x', 'x',
              'o', 'x', 'o', 'o', nil, 'x', 'x',
              'x', 'o', nil, nil, nil, nil, nil,
              'o', nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil
          ]

          board = Board.new(play_area, selections)
          game = Game.new(player1, player2, board)

          expect(game.check_winner).to eq(player2)
        end
        it 'returns player 2 after 28 turns' do
          play_area = [
              'x', 'x', 'o', 'o', 'o', 'x', 'o',
              'x', 'o', 'o', 'x', 'x', 'o', 'o',
              'o', 'x', 'x', 'o', 'o', 'o', 'x',
              'o', 'o', 'x', 'o', 'x', 'x', 'x',
              nil, nil, nil, nil, nil, nil, nil,
              nil, nil, nil, nil, nil, nil, nil
          ]

          board = Board.new(play_area, selections)
          game = Game.new(player1, player2, board)

          expect(game.check_winner).to eq(player2)
        end
      end
    end
  end
end
