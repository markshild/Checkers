require_relative 'dependcies'



class Piece

  DELTAS = [[-1,-1],[-1.1],[1,-1],[1,1]]

  def initialize(pos, color, board, king = false)
    @pos = pos
    @color = color
    @board = board
    @king = king
  end

  def perform_slide

  end

  def perform_jump

  end


  def maybe_promote

  end
end
