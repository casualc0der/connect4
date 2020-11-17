module BoardHelpers
  def fill_up_board(board)
    6.times do |i|
      7.times do |j|
        disc = i % 2 == 0 ? :Y : :R
        board.insert(j+1, disc)
      end
    end
    board
  end
end
