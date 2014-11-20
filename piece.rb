require_relative 'dependencies'



class Piece

  attr_reader :color

  attr_accessor :pos

  DELTAS = [[-1,-1],[-1.1],[1,-1],[1,1]]
  RED_DELTAS = DELTAS[0..1]
  BLACK_DELTAS = DELTAS[1..2]

  RENDER = { black: '⚈', red: '♾' }

  def initialize(pos, color, board, king = false)
    @pos = pos
    @color = color
    @board = board
    @king = king
  end

  def perform_moves!(start,*finish)
    if finish.count == 1
      if perform_slide(finish)
        move_helper!
      elsif perform_jump(finish)
        move_helper!
        mid = [(finish[0] - start[0])/2, (finish[1] - start[1])/2]
        @board[mid] = nil
    elsif valid_move_seq?(@board, start,*finish)

    end
  end

  def valid_move_seq?(nboard, start,*finish)
    duped = nboard.dup
    if *finish.count == 1
      return nboard[start].perform_jump(finish)
    else
      nfinish = finish[0]
      return false if !nboard[start].perform_jump(nfinish)
      valid_move_seq?(duped, nfinish, finish.drop(1))
    end
  end

  def move_helper!(start, finish)
    @board[finish] = self
    self.pos = new_pos
    @board[self.pos] = nil
  end


  def perform_slide(new_pos)

    x2, y2 = new_pos
    x1, y1 = pos
    return true if move_diffs.include?([x2-x1,y2-y1])
    false
  end

  def renders
    RENDER[color]
  end



  def perform_jump(new_pos)
    x2, y2 = new_pos
    x1, y1 = pos
    middle = [(x2-x1)/2 , (y2-y1)/2]
    double = move_diffs.map {|pos| pos.map { |el| el*2} }
    if double.include?([x2-x1,y2-y1]) && !@board[middle].empty && @board[middle].color != color
      return true
    end
    false
  end


  def move_diffs
    x, y = [], []
    if color == :red || king
      x = RED_DELTAS
    elsif color == :black || king
      y = BLACK_DELTAS
    end
    x + y
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
