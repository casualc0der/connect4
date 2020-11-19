class Board
  attr_reader :play_area, :selections
  def initialize(play_area = Array.new(42), selections = [])
    @play_area = play_area
    @selections = selections
  end
  def insert(pos, disc)

    # players can only select from the 7 rows, gravity does the rest
    return false if pos < 1 || pos > 7

    #normalise the position to insert into our array
    pos -= 1

    # find the first available slot within the column
    until play_area[pos].nil?
      pos += 7
    end

    # return false if position is out of bounds after the previous check
    return false unless error_check(pos)

    # otherwise, insert the disc into the board
    @selections << pos
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
