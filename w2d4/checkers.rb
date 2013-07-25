require '../w2d2/chess'

class Checkers
  attr_reader :board

  def initialize
    @board = CheckerBoard.new
  end

  def play
    @board.place_pieces

    @white = HumanPlayer.new(self, :white)
    @red = HumanPlayer.new(self, :red)
  end
end

class CheckerBoard < Board
  def initialize
    super
    @board = create_checker_board(@board)
  end

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
      @board[row][col] = CheckerPiece.new([row, col], side) \
                          unless @board[row][col] == :forbidden_tile
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
    puts '   a b c d e f g h'
  end
end

class CheckerPiece < Piece
  def initialize(pos, side)
    super(pos, side)
    @king = false
  end

  def to_s
    @side == :white ? '@'.bold.gray.bg_cyan : '@'.bold.red.bg_cyan
  end
end

class String
  def red;            "\033[31m#{self}\033[0m" end
  def bg_blue;        "\033[44m#{self}\033[0m" end
end