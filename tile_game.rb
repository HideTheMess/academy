require_relative './tile_board'
require_relative './tile_human_player'

# class Game
#
# end

# class TileBoardGame < Game # TODO when working on Minesweeper
#
# end

class Square8TileGame #< Game # Focus on Chess & Checkers first
  def initialize
    @board = Square8TileBoard.new
    @players = []
  end

  def valid_move?(move_pos, player_side)
    @board.valid_move?(move_pos, player_side)
  end
end
