require_relative 'dependcies'



class Piece

  DELTAS = [[-1,-1],[-1.1],[1,-1],[1,1]]
  red_DELTAS = DELTAS[0..1]
  black_DELTAS = DELTAS[1..2]

  RENDERS = {

  }

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
    if color == :red && pos[0] == 0
      king = true
    elsif color == :black && pos[0] == 7
      king = true
    end
    nil
  end
end
