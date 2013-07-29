require_relative '../w2d2/chess'

class Checkers < Game
  attr_reader :board, :white, :red

  def initialize
    @board = CheckerBoard.new
  end

  def play
    @board.place_pieces

    @white = HumanPlayer.new(self, :white)
    @red   = HumanPlayer.new(self, :red)

    player_toggle = true
    while true # While the game is still on # Debug
      if player_toggle
        begin
          move_pos = @white.make_move
        rescue ArgumentError => error
          puts error.message
        retry
        end

        @board.move_pieces(move_pos)
        player_toggle = false
      else
        begin
          move_pos = @red.make_move
        rescue ArgumentError => error
          puts error.message
        retry
        end

        @board.move_pieces(move_pos)
        player_toggle = true
      end
    end
  end
end

class CheckerBoard < Board
  def initialize
    super # Creates initial @board instance
    @board = create_checker_board(@board)
  end

  def move_pieces(move_pos)
    current_pos, next_pos = move_pos
    super(move_pos)

    # Jump move-specific
    row_diff_abs = (current_pos[0] - next_pos[0]).abs
    if row_diff_abs == 2
      target_row, target_col = target_pos(move_pos)
      @board[target_row][target_col] = nil
    end

    # Side-specific king check
    if @board[next_pos[0]][next_pos[1]].side == :white
      @board[next_pos[0]][next_pos[1]].king = true if next_pos[0] == 0
    else # side == :red
      @board[next_pos[0]][next_pos[1]].king = true if next_pos[0] == 7
    end
  end

  def place_pieces
    # Place red pieces
    (0..2).each do |row|
      place_checker_piece(row, :red)
    end

    # Place white pieces
    (5..7).each do |row|
      place_checker_piece(row, :white)
    end
  end

  def to_s
    puts '   a b c d e f g h'
    puts '  ' + '                 '.bg_cyan
    @board.each_with_index do |row_array, i|
      display = []

      row_array.each do |grid|
        if grid.nil?
          display << '*'.blue.bg_cyan
        elsif grid == :forbidden_tile
          display << ' '.blue.bg_blue
        else
          display << grid
        end
      end

      puts "#{ BOARD_SIZE - i } " + ' '.bg_cyan + \
        "#{ display.join(' '.bg_cyan) }" + ' '.bg_cyan + " #{ BOARD_SIZE - i }"
    end
    puts '  ' + '                 '.bg_cyan
    print '   a b c d e f g h   '
  end

  # Helper methods
  def create_checker_board(board)
    BOARD_SIZE.times do |row|
      BOARD_SIZE.times do |col|
        row_col_equal_parity = row.even? == col.even?

        board[row][col] = :forbidden_tile if row_col_equal_parity
      end
    end
    board
  end

  def place_checker_piece(row, side)
    BOARD_SIZE.times do |col|
      @board[row][col] = CheckerPiece.new(side) \
                          unless @board[row][col] == :forbidden_tile
    end
  end

  def target_pos(move_pos)
    target_pos = []
    current_pos, next_pos = move_pos
    target_pos << (current_pos[0] + next_pos[0]) / 2
    target_pos << (current_pos[1] + next_pos[1]) / 2

    target_pos
  end
end

class CheckerPiece < Piece
  attr_accessor :king # CheckerBoard needs to promote after move

  def initialize(side)
    super(side)
    @king = false
  end

  def valid_move?(move_pos, player_side, board)
    current_pos, next_pos = move_pos

    return false unless board.piece_exist?(current_pos)
    unless board.god_mode # God Mode
    # Move your own pieces
    return false unless player_side \
                        == board.board[current_pos[0]][current_pos[1]].side
    end

    # Make sure all moves are diagonal & correct move length
    row_diff_abs = (current_pos[0] - next_pos[0]).abs
    col_diff_abs = (current_pos[1] - next_pos[1]).abs
    return false unless row_diff_abs == col_diff_abs
    return false if row_diff_abs > 2 # && col_diff_abs > 2

    # Detect another piece already at destination
    return false if board.piece_exist?(next_pos)

    if row_diff_abs == 2
      return false unless valid_jump?(move_pos, board)
    else # if row_diff == 1
      return false unless valid_slide?(move_pos)
    end

    true
  end

  def to_s
    @side == :white ? '@'.bold.gray.bg_cyan : '@'.bold.red.bg_cyan
  end

  # Helper methods
  def valid_jump?(move_pos, board)
    current_pos, next_pos = move_pos

    # Can't jump unless there's an enemy at target
    target_row, target_col = board.target_pos(move_pos)
    return false if board.board[target_row][target_col].nil?

    sides = [:white, :red]
    sides.delete(@side)
    enemy_side = sides[0]

    return false unless board.board[target_row][target_col].side == enemy_side
    true
  end

  def valid_slide?(move_pos)
    return true if @king
    current_pos, next_pos = move_pos

    row_diff = current_pos[0] - next_pos[0]
    # Side-specific checks
    if @side == :white
      return false unless row_diff > 0 # Always going forward
    else # side == :red
      return false unless row_diff < 0
    end

    true
  end
end

class String
  def red;            "\033[31m#{self}\033[0m" end
  def bg_blue;        "\033[44m#{self}\033[0m" end
end

def debug
  c = Checkers.new
  c.play
  # c.red.make_move
end