class Square8TileBoard
  attr_reader :board # Piece(s) need this
  attr_reader :god_mode # Piece(s) & HumanPlayer need this

  def initialize
    @@BOARD_SIZE = 8
    @board = create_board
    @god_mode = false
  end

  def create_board
    new_board = []

    @@BOARD_SIZE.times do
      nil_array = Array.new(@@bss)
      @@BOARD_SIZE.times { nil_array << nil }
      new_board << nil_array
    end

    new_board
  end

  # move_pieces is naive about whether moves are valid; should be checked prior
  def move_pieces(move_pos)
    current_pos, next_pos = move_pos

    @board[next_pos[0]][next_pos[1]] = @board[current_pos[0]][current_pos[1]]
    @board[current_pos[0]][current_pos[1]] = nil
  end

  def piece_exist?(pos)
    row, col = pos
    return true if @board[row][col].is_a?(Piece)
    false
  end

  def toggle_god_mode
    @god_mode = !@god_mode
  end

  def valid_move?(move_pos, player_side)
    current_pos = move_pos[0]
    @board[current_pos[0]][current_pos[1]].valid_move?(move_pos, \
                                                      player_side, self)
  end
end