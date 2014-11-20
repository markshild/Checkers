require_relative 'dependencies'

class MoveError < StandardError
end

class Piece

  attr_reader :color, :king

  attr_accessor :pos

  DELTAS = [[-1,-1],[-1,1],[1,-1],[1,1]]
  RED_DELTAS = DELTAS[0..1]
  BLACK_DELTAS = DELTAS[2..3]

  RENDER = { black: '⚈', red: '♾' }

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
      @board[start].perform_slide(finish)

      @board[start].perform_jump(finish)

    elsif valid_move_seq?(@board, move_array)
      perform_moves!(move_array[0..1])
      perform_moves!(move_array.drop(1))
    else
      raise MoveError "Invalid Move Error"
    end
  end

  def valid_move_seq?(nboard, move_array)
    duped = nboard.dup
    start = move_array[0]
    finish = move_array[1]
    if move_array.count == 2
      return nboard[start].perform_jump(finish)
    else
      return false if !nboard[start].perform_jump(finish)
      valid_move_seq?(duped, finish, move_array.drop(1))
    end
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
    double = move_diffs.map {|pos| pos.map { |el| el*2} }
    p middle
    p @board[middle].pos
    p @board[middle].color
    if double.include?([x2-x1,y2-y1]) && (!@board[middle].nil? && @board[middle].color != self.color)
      move_helper!(self.pos,new_pos)
      @board[middle] = nil

    end

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
