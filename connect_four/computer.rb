#computer
require_relative 'player'

class Computer < Player
  def initialize(piece)
    @name = 'Computer'
    @piece = piece
  end

  def prompt_move
    rand(0..6)
  end
end
