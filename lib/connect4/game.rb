require_relative 'win_conditions'

class Game
  include Connect4WinConditions
  attr_reader :player1, :player2, :board, :winning_positions
  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @board = board
    @winning_positions = permutations
  end

  def check_winner

    # we need a loop here to check the permutations
    @winning_positions.each do |line|

      discs = board.play_area.values_at(line[0],line[1],line[2],line[3])

      # how many discs in the slice
      number_of_discs = discs.compact.length

      # not enough discs in the slice to confirm a winner
      next if number_of_discs < 4

      # the slice must all be one colour to declare a winner
      next if discs.uniq.length > 1

      # if we've got this far then someone has won...
      # if its not player 1, its player 2!
      return player1.disc_check(discs.uniq.first) ? player1 : player2
    end

    # if we exit the loop, it means no one has won
    false
  end
end
