require_relative '../tile_game'
require_relative './checker_board'


class Checkers < Game
  # attr_reader :board # Unknown who needs this
  attr_reader :white, :red # Debug

  def initialize
    super
    @board = CheckerBoard.new
  end

  def play
    @board.place_pieces

    @players << HumanPlayer.new(self, :white)
    @players << HumanPlayer.new(self, :red)

    loop do
      @players.each do |player|
        take_turn(player)
      end
    end

    # player_toggle = true
#     while true # While the game is still on # Debug
#       if player_toggle
#         begin
#           move_pos = @white.make_move
#         rescue ArgumentError => error
#           puts error.message
#         retry
#         end
#
#         @board.move_pieces(move_pos)
#         player_toggle = false
#       else
#         begin
#           move_pos = @red.make_move
#         rescue ArgumentError => error
#           puts error.message
#         retry
#         end
#
#         @board.move_pieces(move_pos)
#         player_toggle = true
#       end
#     end
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
