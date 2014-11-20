require_relative 'dependencies'

class Game

  def initialize
    @board = Board.new
  end

  def play
    until over?
      @board.display
      begin
        move = get_move
        @board.move(move)
      rescue StandardError => e
        puts e.message
        retry
      end
      switch_move
      @board.promote
    end
    switch_move
    puts "#{@board.current_turn.to_s.capitalize} wins!"
  end

  def over?
    @board.white_pieces.count == 0 || @board.black_pieces.count == 0
  end

  def get_move
    puts "#{@board.current_turn.to_s.capitalize} please enter your move"
    move = gets.chomp.split
    move.map! do |pos|
      pos.split('').map! {|num| num.to_i - 1}
    end
    move
    p move
  end

  def switch_move
    @board.current_turn == :white ? @board.current_turn = :black :  @board.current_turn = :white
  end

end

if __FILE__ == $PROGRAM_NAME

  g = Game.new
  g.play


end
