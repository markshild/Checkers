require_relative 'dependencies'

class Board

  def initialize
    @rows = Array.new(8){ Array.new(8){ nil } }
    @players = {
        red: HumanPlayer.new
        black: HumanPlayer.new
    }
    fill_board
  end

  def [](pos)
    raise 'invalid pos' unless valid_pos?(pos)

    x, y = pos
    @rows[x][y]
  end

  def []=(pos, value)
    raise 'invalid pos' unless valid_pos?(pos)

    x, y = pos
    @rows[x][y] = value
  end

  def add_piece(piece, pos)
    raise 'position not empty' unless empty?(pos)

    self[pos] = piece
  end

  def empty?(pos)
    self[pos].nil?
  end

  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def pieces
    @rows.flatten.compact
  end

  protected

  def fill_board
    @rows.each_with_index do |row,rind|
      row.each_index do |cind|
        pos = [rind,cind]
        next if rind.between(4,5)
        if (rind + cind).odd?
          if rind < 4
            @board[pos] = Piece.new(pos,:black, self)
          elsif rind > 5
            @board[pos] = Piece.new(pos,:red, self)
          end
        end

      end
    end


end
