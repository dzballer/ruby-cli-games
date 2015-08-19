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

