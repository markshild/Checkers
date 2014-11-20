require_relative 'dependencies'

class Game

  def initialize
    @board = Board.new
  end

  def play
    while true
      @board.display
      # begin
        move = get_move
        @board.move(move)
      # rescue StandardError => e
      #   puts e.message
      #   retry
      # end
      switch_move
      @board.promote
    end
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
