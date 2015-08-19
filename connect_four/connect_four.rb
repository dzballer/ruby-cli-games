# Your code here!
class ConnectFour
  require 'array'
  require 'board'
  require 'player'

  attr_accessor :players, :board

  def initialize
    @players = []
    @board = Board.new

    prompt_mode
    prompt_players
  end

  # play game
  def play
    until win?
      players.each do |player|
        @board.add_piece(player.prompt_move, player.piece)
      end
    end
  end

  # checking win condition
  def win?
    @board.winning_diagonal? || @board.winning_horizontal? || @board.winning_vertical?
  end

  # prompting player information from user
  def prompt_players
    puts "P1: "
    players.push(Player.new)
    puts "P2: "
    players.push(Player.new)
  end

  # prompting play mode from user
  def prompt_mode
    puts "Do you want to play 2 Player or against AI?"
    @mode = gets.chomp
  end
end
