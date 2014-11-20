require_relative 'dependencies'

class Game

  def initialize
    @board = Board.new
    @current_move = :red
  end

  def play
    while true
      board.display
      begin
        move = get_move
        @board.move(move)
      rescue StandardError => e
        puts e.message
        retry
      end
      switch_move
    end
  end

  def get_move
    puts "#{@current_move.to_s.capitalize} please enter your move"
    move = gets.chomp.split
    move.map! do |pos|
      pos.split('').map! {|num| num.to_i - 1}
    end
    move
    p move
  end

  def switch_move
    @current_move == :red ? @current_move = :black :  @current_move = :red
  end

end
