class Board
  def initialize
    # setting up a board with 7 columns and 6 rows
    @board = Array.new(7){Array.new(6, " ")}
  end

  # prints out the board
  def render
    row = @board[0].length-1
    until row < 0 do #basically go through each column #_with_index do |col, i|
      @board.each_with_index do |col|
        # starting from the top of the board, print row by row from left to right
        print (col[row] == " " ? "|_" : "|#{col[row]}")
      end
      print "|\n" # on the the next row
      row -= 1
    end
  end

  # adds a piece to the board 
  def add_piece(col, piece)
    # won't add piece if col is full
    if full?(col) 
      puts "The column is full." 
    else
      # otherwise adds the piece in the first non-occupied (nil) space
      @board[col].each_with_index do |p, i|
        # if empty square, we can add the piece
        if p == " "
          # save the position by [col, row] to check win condition
          @last_placed_piece_coordinate = [col, i]
          @last_placed_piece = piece
      
          # adding the piece
          @board[col][i] = piece
          puts "#{@last_placed_piece} played: #{@last_placed_piece_coordinate}"
          break
        end
      end
    end
  end

  # checks if a column is full
  def full?(col)
    @board[col].last != " "
  end

  # win conditions
  def winning_diagonal?
    botleft_topright_diagonal.four_in_a_row?(@last_placed_piece) || topleft_botright_diagonal.four_in_a_row?(@last_placed_piece)
  end

  # get the bottom left to top right diagonal of a piece
  def botleft_topright_diagonal(point = @last_placed_piece_coordinate)
    diagonal = []
    botleft_point = point.dup
    topright_point = point.dup

    diagonal.push(@board[point[0]][point[1]])

    while within_grid?(botleft_point) do
      # traverse from center point to bot left and top right simultaneously
      # while prepending and appending the array to form a diagonal
      botleft_point[0] -= 1
      botleft_point[1] -= 1
      diagonal.unshift(@board[botleft_point[0]][botleft_point[1]]) if within_grid?(botleft_point)
    end

    while within_grid?(topright_point) do
      topright_point[0] += 1
      topright_point[1] += 1
      diagonal.push(@board[topright_point[0]][topright_point[1]]) if within_grid?(topright_point)
    end

    diagonal
  end

  # get the top left to bottom right diagonal of a piece
  def topleft_botright_diagonal(point = @last_placed_piece_coordinate.dup)
    diagonal = []
    topleft_point = point.dup
    botright_point = point.dup

    diagonal.push(@board[point[0]][point[1]])

    while within_grid?(topleft_point) do
      # traversing the other diagonal (top left to bot right)
      topleft_point[0] -= 1
      topleft_point[1] += 1
      diagonal.unshift(@board[topleft_point[0]][topleft_point[1]]) if within_grid?(topleft_point)
    end

    while within_grid?(botright_point) do
      botright_point[0] += 1
      botright_point[1] -= 1
      diagonal.push(@board[botright_point[0]][botright_point[1]]) if within_grid?(botright_point)
    end

    diagonal
  end

  # check if coord = [x,y] is within the board
  def within_grid?(coord)
    # coord needs to be within col 0-6 and row 0-5
    (coord[0] >= 0 && coord[0] <= 6 && coord[1] >= 0 && coord[1] <= 5)
  end

  def winning_horizontal?
    horizontal = []
    row = @last_placed_piece_coordinate[1]

    @board.each do |col|
      horizontal.push(col[row])
    end

    horizontal.four_in_a_row?(@last_placed_piece)
  end

  def winning_vertical?
    # check if there is a consecutive 4 in column 
    @board[@last_placed_piece_coordinate[0]].four_in_a_row?(@last_placed_piece)
  end
end