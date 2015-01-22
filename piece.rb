require_relative 'dependencies'

class MoveError < StandardError
end

class Piece

  attr_reader :color, :king

  attr_accessor :pos

  DELTAS = [[-1,-1],[-1,1],[1,-1],[1,1]]
  RED_DELTAS = DELTAS[0..1]
  BLACK_DELTAS = DELTAS[2..3]

  RENDER = { black: '⚈', white: '♾' }

  def initialize(pos, color, board, king = false)
    @pos = pos
    @color = color
    @board = board
    @king = king
  end

  def perform_moves!(move_array)
    start = move_array.first
    finish = move_array[1]
    if move_array.count == 2
      unless @board[start].perform_slide(finish)
        @board[start].perform_jump(finish)
      end

    elsif valid_move_seq?(move_array)
      until move_array.count < 2
        start = move_array.shift
        finish = move_array.first
        @board[start].perform_jump(finish)
      end
    else
      raise MoveError.new("Invalid Move Error")
    end
  end

  def valid_move_seq?(move_array)
    duped = @board.dup
    move_array = move_array.dup
    until move_array.count < 2
      start = move_array.shift
      finish = move_array.first
      unless duped[start].perform_jump(finish)
        return false
      end
    end
    true
  end

  def move_helper!(start, finish)
    @board[finish] = @board[start]
    @board[finish].pos = finish
    @board[start] = nil
  end


  def perform_slide(new_pos)

    x2, y2 = new_pos
    x1, y1 = self.pos
    if move_diffs.include?([x2-x1,y2-y1])
      move_helper!(self.pos,new_pos)
      return true
    end
    nil
  end

  def renders
    RENDER[color]
  end



  def perform_jump(new_pos)
    x2, y2 = new_pos
    x1, y1 = pos
    middle = [(x2+x1)/2 , (y2+y1)/2]
    diff = [x2 - x1, y2 - y1]
    double = move_diffs.map {|(x, y)| [x * 2, y * 2] }
    p double
    p move_diffs
    if double.include?(diff) && (!@board[middle].nil? && @board[middle].color != self.color)
      move_helper!(self.pos,new_pos)
      @board[middle] = nil
      return true
    end
    false
  end


  def move_diffs
    x, y = [], []
    if color == :white || king
      x = RED_DELTAS
    elsif color == :black || king
      y = BLACK_DELTAS
    end
    x + y
  end

  def maybe_promote
    if color == :white && pos[0] == 0
      king = true
    elsif color == :black && pos[0] == 7
      king = true
    end
    nil
  end
end
