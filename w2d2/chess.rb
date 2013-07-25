BOARD_SIZE = 8

class Chess
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    board.place_pieces
  end
end

class Board
  attr_reader :board # Debug

  def initialize
    @board = create_board

  end

  def create_board
    new_board = []

    BOARD_SIZE.times do
      nil_array = []
      BOARD_SIZE.times { nil_array << nil }
      new_board << nil_array
    end

    new_board
  end

  def place_pieces
    # Place pawns
    BOARD_SIZE.times do |col|
      row = 1
      @board[row][col] = Pawn.new([row, col], :black)
      row = 6
      @board[row][col] = Pawn.new([row, col], :white)
    end

  end

  def to_s
    @board.each do |row_array|
      display = []

      row_array.each do |grid|
        grid.nil? ? display << ' '.bg_gray : display << grid
      end

      puts "#{display.join(' '.bg_gray)}"
    end
  end
end

class Piece
  def initialize(pos, side)
    @pos, @side = pos, side
  end
end

class Pawn < Piece
  def initialize(pos, side)
    super(pos, side)
  end

  def to_s
    @side == :white ? 'P'.red.bg_gray : 'P'.blue.bg_gray
  end
end

class Rook < Piece
  def initialize(pos, side)
    super(pos, side)
  end

  def to_s
    @side == :white ? 'R'.red.bg_gray : 'R'.blue.bg_gray
  end
end

class Knight < Piece
  def initialize(pos, side)
    super(pos, side)
  end

  def to_s
  @side == :white ? 'K'.red.bg_gray : 'K'.blue.bg_gray
  end
end

class Bishop < Piece
  def initialize(pos, side)
    super(pos, side)
  end

  def to_s
    @side == :white ? 'B'.red.bg_gray : 'B'.blue.bg_gray
  end
end

class Queen < Piece
  def initialize(pos, side)
    super(pos, side)
  end

  def to_s
    @side == :white ? 'Q'.red.bg_gray : 'Q'.blue.bg_gray
  end
end

class King < Piece
  def initialize(pos, side)
    super(pos, side)
  end

  def to_s
    @side == :white ? 'O'.red.bg_gray : 'O'.blue.bg_gray
  end
end

class HumanPlayer
end

class String
  def black;          "\033[30m#{self}\033[0m" end
  def red;            "\033[31m#{self}\033[0m" end # :)
  def green;          "\033[32m#{self}\033[0m" end
  def  brown;         "\033[33m#{self}\033[0m" end
  def blue;           "\033[34m#{self}\033[0m" end # :)
  def magenta;        "\033[35m#{self}\033[0m" end
  def cyan;           "\033[36m#{self}\033[0m" end
  def gray;           "\033[37m#{self}\033[0m" end
  def bg_black;       "\033[40m#{self}\0330m"  end
  def bg_red;         "\033[41m#{self}\033[0m" end
  def bg_green;       "\033[42m#{self}\033[0m" end
  def bg_brown;       "\033[43m#{self}\033[0m" end
  def bg_blue;        "\033[44m#{self}\033[0m" end
  def bg_magenta;     "\033[45m#{self}\033[0m" end
  def bg_cyan;        "\033[46m#{self}\033[0m" end
  def bg_gray;        "\033[47m#{self}\033[0m" end # :)
  def bold;           "\033[1m#{self}\033[22m" end
  def reverse_color;  "\033[7m#{self}\033[27m" end
end
