require_relative '../tile_board'

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