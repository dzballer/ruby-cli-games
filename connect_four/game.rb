require_relative 'array'
require_relative 'board'
require_relative 'player'
require_relative 'computer'

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

    loop do
      players.each do |player|
        loop do
          col = player.prompt_move
          if !@board.full?(col)
            @board.add_piece(col, player.piece)
            break
          else
            puts "Column is full, please try again" if !player.is_a?(Computer)
          end
        end
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
      print "Human: "
      players.push(Player.new)
      if players[0].piece == 'x'
        players.push(Computer.new('o'))
      else
        players.push(Computer.new('x'))
      end
    else raise "Invalid input"
    end
  end

  # prompting play mode from user
  def prompt_mode
    puts "Do you want to play 2 Player or against computer? ('2p' or 'c'): "
    @mode = gets.chomp
  end
end
