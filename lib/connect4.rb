require_relative './connect4/board'
require_relative './connect4/formatter'
require_relative './connect4/game'
require_relative './connect4/player'


class Connect4

  def self.play
    puts 'Player 1 enter your name'
    player1 = Player.new(gets.chomp, 'O')
    puts 'Player 2 enter your name'
    player2 = Player.new(gets.chomp, 'X')
    board = Board.new
    game = Game.new(player1, player2, board)

    until game.check_winner
      puts "#{player1.name} select a column"
      choice = (gets.chomp).to_i
      board.insert(choice, player1.disc)
      puts Formatter.print(board)
      puts "#{player2.name} select a column"
      choice = (gets.chomp).to_i
      board.insert(choice, player2.disc)
      puts Formatter.print(board)
    end
  end
end

Connect4.play