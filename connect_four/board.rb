class Board
  def initialize
    # setting up a board with 7 columns and 6 rows
    #***  warning: block supersedes default value argument
    @board = Array.new(7){Array.new(6, " ")}
  end

  # prints out the board
  def render
    row = @board[0].length
    until row < 0 do #basically go through each column #_with_index do |col, i|
      @board.each_with_index do |col|
        # starting from the top of the board, print row by row from left to right
        print (col[row].nil? ? " " : "#{col[row]}")
      end
      print "\n" # on the the next row
      row -= 1
    end
  end

  # adds a piece to the board 
  def add_piece(col, piece)
    # won't add piece if col is full
    if full?(@board[col]) 
      puts "The column is full." 
    else
      # otherwise adds the piece in the first non-occupied (nil) space
      @board[col].map_with_index do |p, i|
        if p.nil?
          # save the position by [col, row] to check win condition
          @last_placed_piece_coordinate = [col, i]
          @last_placed_piece = piece
          # return piece
          piece

          break
        end
      end
    end
  end

  # checks if a column is full
  def full?(col)
    !col.last.nil?
  end

  # win conditions
  def winning_diagonal?
    botleft_topright_diagonal.four_in_a_row? || topleft_botright_diagonal.four_in_a_row?
  end

  # get the bottom left to top right diagonal of a piece
  def botleft_topright_diagonal(point = @last_placed_piece_coordinate)
    diagonal = []
    botleft_point = point
    topright_point = point

    diagonal.push(point)

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
  def topleft_botright_diagonal(point = @last_placed_piece_coordinate)
    diagonal = []
    topleft_point = point
    botright_point = point
    while within_grid?(point) do
      # traversing the other diagonal (top left to bot right)
      topleft_point[0] -= 1
      topleft_point[1] -= 1
      diagonal.unshift(@board[topleft_point[0]][topleft_point[1]]) if within_grid?(point)
    end

    while within_grid?(botright_point) do
      botright_point[0] += 1
      botright_point[1] += 1
      diagonal.push(@board[botright_point[0]][botright_point[1]]) if within_grid?(point)
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

    @board.each_with_index do |col, i|
      horizontal.push(col[i])
    end

    horizontal.four_in_a_row?
  end

  def winning_vertical?
    # check if there is a consecutive 4 in column 
    @board[@last_placed_piece_coordinate[0]].join.include?("#{last_placed_piece}" * 4)
  end
end