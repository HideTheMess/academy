require_relative '../../tile_game.rb'

class Chess < Square8TileGame
  # attr_reader :board # Unknown who needs this
  attr_reader :white, :black # Debug

  def initialize
    super
    @board = ChessBoard.new
  end

  def play
    @board.place_pieces

    @players << HumanPlayer.new(self, :white)
    @players << HumanPlayer.new(self, :black)

    loop do
      @players.each do |player|
        take_turn(player)
      end
    end

    # player_toggle = true
#     # while false # While the game is still on # Debug
#       if player_toggle
#         begin
#           move_pos = @white.make_move
#         rescue ArgumentError
#         rescue Over9000Error
#         retry
#         end
#
#         @board.move_pieces(move_pos)
#         player_toggle = false
#       else
#         begin
#           move_pos = @black.make_move
#         rescue ArgumentError
#         rescue Over9000Error
#         retry
#         end
#
#         @board.move_pieces(move_pos)
#         player_toggle = true
#       end
#     # end
  end

  def take_turn(player)
    begin
      move_pos = player.make_move
    rescue ArgumentError
    rescue Over9000Error
    retry
    end

    @board.move_pieces(move_pos)
  end

end

