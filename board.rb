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




end
