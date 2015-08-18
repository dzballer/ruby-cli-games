# Your code here!
class ConnectFour
  attr_accessor :players, :board

  def initialize
    @players = []
    @board = Board.new

    prompt_mode
    prompt_players
  end

  def play
    until win?
      players.each do |player|
        @board.add_piece(player.prompt_move, player.piece)
      end
    end
  end

  def win?
    @board.winning_diagonal? || @board.winning_horizontal? || @board.winning_vertical?
  end

  def prompt_players
    puts "P1: "
    players.push(Player.new)
    puts "P2: "
    players.push(Player.new)
  end

  def prompt_mode
    puts "Do you want to play 2 Player or against AI?"
    @mode = gets.chomp
  end
end

class Board
  def initialize
    # setting up a board with 7 columns and 6 rows
    @board = Array.new(7){Array.new(6)}
  end

  def render
    row = @board[0].length
    until row < 0 #basically go through each column #_with_index do |col, i|
      @board.each_with_index do |col|
        # starting from the top of the board, print row by row from left to right
        print (col[row].nil? ? " " : "#{col[row]}")
      end
      print "\n" # on the the next row
      row -= 1
    end
  end

  def add_piece(col, piece)
    @board[col].push(piece)
    ######******@last_placed_piece_coordinate = [col, ]
  end

  # win conditions
  def winning_diagonal?
  end

  def winning_horizontal?
  end

  def winning_vertical?
  end
end

class Player
  attr_accessor :name, :piece

  def initialize()
    prompt_name
    prompt_piece
  end

  def prompt_name
    puts "Enter Player's name: "
    @name = gets.chomp
  end

  def prompt_piece
    puts "Do you want to play as the 'x' or 'o'?"
    @piece = gets.chomp
  end

  def prompt_move
    puts "Which column would you like to put your piece in? (Enter a number from 0-6)"
    col = gets.chomp.to_i
  end


end

