require_relative './connect4/board'
require_relative './connect4/formatter'
require_relative './connect4/game'
require_relative './connect4/player'


class Connect4

  def self.play
    system("clear")
    puts 'Player 1 enter your name'
    player1 = Player.new(gets.chomp, 'O')
    puts 'Player 2 enter your name'
    player2 = Player.new(gets.chomp, 'X')
    board = Board.new
    game = Game.new(player1, player2, board)
    winner = nil
    current_player = player1

    # the main game loop
    loop do
      if board.full?
        puts "Its a draw!"
        return
      end
      system("clear")
      puts "#{current_player.name} select a column"
      puts Formatter.print(board)
      choice = (gets.chomp).to_i
      while board.insert(choice, current_player.disc) == false
        system("clear")
        puts Formatter.print(board)
        puts "sorry, invalid choice, please choose a different column!"
        choice = (gets.chomp).to_i
      end

      puts Formatter.print(board)
      if game.check_winner
        winner = current_player
        break
      end
      current_player = current_player == player1 ? player2 : player1
    end
    puts "Congratulations #{winner.name}, you won!"

  end
end

Connect4.play