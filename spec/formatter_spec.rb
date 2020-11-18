require_relative 'board_spec'
# the formatter does not need to store any state, so it will be a 'static' class only

class Formatter
  def self.print(board)

    b = board.play_area.map {|disc|
      disc = " " if disc.nil?
      disc }

    return  <<~BOARD

      ___1_____2_____3_____4_____5_____6_____7___
      |     |     |     |     |     |     |     |
      |  #{b[35]}  |  #{b[36]}  |  #{b[37]}  |  #{b[38]}  |  #{b[39]}  |  #{b[40]}  |  #{b[41]}  | 
      |_____|_____|_____|_____|_____|_____|_____|
      |     |     |     |     |     |     |     |
      |  #{b[28]}  |  #{b[29]}  |  #{b[30]}  |  #{b[31]}  |  #{b[32]}  |  #{b[33]}  |  #{b[34]}  | 
      |_____|_____|_____|_____|_____|_____|_____|
      |     |     |     |     |     |     |     |
      |  #{b[21]}  |  #{b[22]}  |  #{b[23]}  |  #{b[24]}  |  #{b[25]}  |  #{b[26]}  |  #{b[27]}  | 
      |_____|_____|_____|_____|_____|_____|_____|
      |     |     |     |     |     |     |     |
      |  #{b[14]}  |  #{b[15]}  |  #{b[16]}  |  #{b[17]}  |  #{b[18]}  |  #{b[19]}  |  #{b[20]}  | 
      |_____|_____|_____|_____|_____|_____|_____|
      |     |     |     |     |     |     |     |
      |  #{b[7]}  |  #{b[8]}  |  #{b[9]}  |  #{b[10]}  |  #{b[11]}  |  #{b[12]}  |  #{b[13]}  | 
      |_____|_____|_____|_____|_____|_____|_____|
      |     |     |     |     |     |     |     |
      |  #{b[0]}  |  #{b[1]}  |  #{b[2]}  |  #{b[3]}  |  #{b[4]}  |  #{b[5]}  |  #{b[6]}  | 
      |_____|_____|_____|_____|_____|_____|_____|
    BOARD

  end

end


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