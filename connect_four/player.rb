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
    loop do
      puts "Do you want to play as the 'x' or 'o'?"
      @piece = gets.chomp
      if ['x','o'].include?(@piece)
        break
      else
        puts "Invalid input. Please try again."
      end
    end
  end

  def prompt_move
    col = ""

    loop do
      puts "#{@name}, which column would you like to put your piece in? (Enter a number from 0-6)"
      col = gets.chomp.to_i
      if col >= 0 && col <= 6
        break
      else
        puts "Invalid input. Please try again."
      end
    end

    col
    
  end
end

