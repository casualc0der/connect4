require './spec/support/board_helpers'
class Board
  attr_reader :play_area
  def initialize
    @play_area = Array.new(42)
  end
  def insert(pos, disc)

    # players can only select from the 7 rows, gravity does the rest
    return false if pos < 1 || pos > 7

    #normalise the pos to insert into our array
    pos -= 1

    # find the first available slot within the column
    until play_area[pos].nil?
      pos += 7
    end

    # return false if position is out of bounds after the previous check
    return false unless error_check(pos)

    # otherwise, insert the disc into the board
    @play_area[pos] = disc

  end

  def full?
    # Check to see if the board is full. Remove nils and count the length
    @play_area.compact.size == 42
  end

  private

  def error_check(pos)
    # if the pos is not included in the range 0-41, the move is not valid
    (0..41).include?(pos)
  end
end

RSpec.configure do |c|
  c.include BoardHelpers
end
RSpec.describe Board do
  describe 'When first created' do
    let(:board) { Board.new }

    it {should_not be_nil}
    it 'should create a play area' do
      expect(board.play_area).to eq(Array.new(42))
    end
  end

  describe '#insert' do
    let (:board) { Board.new }

    context 'when supplied with a number 1-7' do
      it 'should insert a "disc" at the correct index' do
        7.times do |i|
          disc = i % 2 == 0 ? :Y : :R
          board.insert(i+1, disc)
        end
        expect(board.play_area[0...7]).to eq([:Y, :R, :Y, :R, :Y, :R, :Y])
      end
      it 'should insert into next row if position already has a disc' do
        board.insert(1, :Y)
        board.insert(1, :R)
        expect(board.play_area[0]).to eq(:Y)
        expect(board.play_area[7]).to eq(:R)
      end
      it 'should return false if the disc will overflow' do
        6.times do |i|
          disc = i % 2 == 0 ? :Y : :R
          board.insert(1, disc)
        end
        expect(board.insert(1, :Y)).to be(false)
      end
    end

    context 'when supplied with a number less than 1' do
      it 'should return false' do
        expect(board.insert(0, :Y)).to be(false)
      end
    end
    context 'when supplied with a number greater than 7' do
      it 'should return false' do
        expect(board.insert(8, :Y)).to be(false)
      end
    end

    context 'when playing a full game (insert 42 discs)' do
      before do
        fill_up_board(board)
      end
      it 'should fill up sequentially' do
        expect(board.play_area).to eq([:Y, :Y, :Y, :Y, :Y, :Y, :Y,
                                       :R, :R, :R, :R, :R, :R, :R,
                                       :Y, :Y, :Y, :Y, :Y, :Y, :Y,
                                       :R, :R, :R, :R, :R, :R, :R,
                                       :Y, :Y, :Y, :Y, :Y, :Y, :Y,
                                       :R, :R, :R, :R, :R, :R, :R])
      end
      it 'should not allow any further moves' do
        expect(board.insert(1, :Y)).to be(false)
      end
    end
  end
  describe '#board_full?' do
    let(:board) { Board.new }

    context 'if board is full' do
      before do
        fill_up_board(board)
      end
      it 'returns true' do
        expect(board.full?).to eq(true)
      end
    end
    context 'if board is not full' do
      it 'returns false' do
        expect(board.full?).to eq(false)
      end
    end

  end
end
