require_relative '../lib/connect4/board'
require_relative '../lib/connect4/formatter'
# the formatter does not need to store any state, so it will be a 'static' class only


RSpec.describe Formatter do

  describe 'self.print' do
    context 'When the board is empty' do
      it 'prints out an empty board' do
        board = Board.new
        output = Formatter.print(board)

        connect_4_board = <<~BOARD

          ___1_____2_____3_____4_____5_____6_____7___
          |     |     |     |     |     |     |     |
          |     |     |     |     |     |     |     | 
          |_____|_____|_____|_____|_____|_____|_____|
          |     |     |     |     |     |     |     |
          |     |     |     |     |     |     |     | 
          |_____|_____|_____|_____|_____|_____|_____|
          |     |     |     |     |     |     |     |
          |     |     |     |     |     |     |     | 
          |_____|_____|_____|_____|_____|_____|_____|
          |     |     |     |     |     |     |     |
          |     |     |     |     |     |     |     | 
          |_____|_____|_____|_____|_____|_____|_____|
          |     |     |     |     |     |     |     |
          |     |     |     |     |     |     |     | 
          |_____|_____|_____|_____|_____|_____|_____|
          |     |     |     |     |     |     |     |
          |     |     |     |     |     |     |     | 
          |_____|_____|_____|_____|_____|_____|_____|
        BOARD


        expect(output).to eq(connect_4_board)
      end
    end

    context 'when the board is not empty' do
      it 'prints out in the correct format' do
        play_area = [
            '1', '2', '3', '4', '5', '6', '7',
            '8', '9', 'a', 'b', nil, 'c', 'd',
            'e', nil, nil, nil, nil, nil, nil,
            'f', nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil,
            nil, nil, nil, nil, nil, nil, nil
        ]

        board = Board.new(play_area)
        
        output = Formatter.print(board)

        connect_4_board = <<~BOARD

          ___1_____2_____3_____4_____5_____6_____7___
          |     |     |     |     |     |     |     |
          |     |     |     |     |     |     |     | 
          |_____|_____|_____|_____|_____|_____|_____|
          |     |     |     |     |     |     |     |
          |     |     |     |     |     |     |     | 
          |_____|_____|_____|_____|_____|_____|_____|
          |     |     |     |     |     |     |     |
          |  f  |     |     |     |     |     |     | 
          |_____|_____|_____|_____|_____|_____|_____|
          |     |     |     |     |     |     |     |
          |  e  |     |     |     |     |     |     | 
          |_____|_____|_____|_____|_____|_____|_____|
          |     |     |     |     |     |     |     |
          |  8  |  9  |  a  |  b  |     |  c  |  d  | 
          |_____|_____|_____|_____|_____|_____|_____|
          |     |     |     |     |     |     |     |
          |  1  |  2  |  3  |  4  |  5  |  6  |  7  | 
          |_____|_____|_____|_____|_____|_____|_____|
        BOARD

        expect(output).to eq(connect_4_board)

      end
    end
  end

end
