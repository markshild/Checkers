require_relative 'dependencies'

class Board

  def initialize(fill = true)
    @rows = Array.new(8){ Array.new(8){ nil } }
    # @players = {
    #     red: HumanPlayer.new  ,
    #     black: HumanPlayer.new
    # }
    fill_board if fill
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

  def move(start,finish)
    raise "No Piece to move" if empty?(start)
    @board[start].perform_moves!
  end

  def empty?(pos)
    self[pos].nil?
  end

  def display
    working_array =

    render.map.with_index do |row, rowidx|
      row.unshift(rowidx + 1).join(" ║ ")
    end

    display_array = ["    1   2   3   4   5   6   7   8",
                     "  ╔═══╦═══╦═══╦═══╦═══╦═══╦═══╦═══╗"]

    8.times do display_array << (working_array.shift) + ' ║'

    display_array << "  ╠═══╬═══╬═══╬═══╬═══╬═══╬═══╬═══╣"

    end

    display_array.pop

    display_array << "  ╚═══╩═══╩═══╩═══╩═══╩═══╩═══╩═══╝"

    puts display_array
  end

  def render

    rendered_board = @rows.map do |row| #set to variable
      row.map do |space|
        if space.nil?
          " "
        else
          space.renders
        end
      end
    end

    rendered_board
  end

  def valid_pos?(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def pieces
    @rows.flatten.compact
  end


  def dup
    dup_board = Board.new(false)
    @rows.each_with_index do |row, ind1|
      row.each_with_index do |item, ind2|
          posi = [ind1, ind2]
          checker = self[posi]
          unless empty?(posi)
            dup_board[posi] = Piece.new(posi,checker.color, dup_board, checker.king)
          end
      end
    end
    dup_board
  end

  protected

  def fill_board
    (0..7).each do |row|
      (0..7).each do |col|
        pos = [row,col]
        next if row.between?(3,4)
        if (row + col).odd?
          if row < 3
            self[pos] = Piece.new(pos, :black, self)
          elsif row > 4
            self[pos] = Piece.new(pos, :red, self)
          end
        end

      end
    end
  end


end
