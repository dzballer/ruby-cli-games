require_relative 'array'
require_relative 'board'
require_relative 'player'

# Your code here!
class Game
  attr_accessor :players, :board

  def initialize
    @players = []
    @board = Board.new

    prompt_mode
    prompt_players
  end

  # play game
  def play
    @board.render
    # want to use until but also want to execute code on win - seems redundant
    while true do
      players.each do |player|
        @board.add_piece(player.prompt_move, player.piece)
        @board.render
        if win?
          puts "Congratulations, #{player.name} wins!" 
          return
        end
      end
    end
  end

  # checking win condition
  def win?
    @board.winning_diagonal? || @board.winning_horizontal? || @board.winning_vertical?
  end

  # prompting player information from user
  def prompt_players
    if @mode == '2p'
      print "P1: "
      players.push(Player.new)
      print "P2: "
      players.push(Player.new)
    elsif @mode == 'c'
      puts "pc mode"
    else raise "Invalid input"
    end
  end

  # prompting play mode from user
  def prompt_mode
    puts "Do you want to play 2 Player or against computer? ('2p' or 'c'): "
    @mode = gets.chomp
  end
end
