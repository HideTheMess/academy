BOARD_SIZE = 8

class Chess
  attr_reader :board
  attr_reader :white, :black # Debug

  def initialize
    @board = ChessBoard.new
  end

  def play
    @board.place_pieces

    @white = HumanPlayer.new(self, :white)
    @black = HumanPlayer.new(self, :black)

    player_toggle = true
    while false # While the game is still on
      if player_toggle
        current_pos, next_pos = @white.make_move

        @board.move_pieces(current_pos, next_pos)
        player_toggle = false
      else
        current_pos, next_pos = @black.make_move

        @board.move_pieces(current_pos, next_pos)
        player_toggle = true
      end
    end
  end

  def valid_move?(move_pos, side)
    @board.valid_move?(move_pos, side)
  end
end

class Board
  attr_reader :board

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

  def move_pieces(current_pos, next_pos)

  end
end

class ChessBoard < Board
  def place_pieces
    # Place pawns
    BOARD_SIZE.times do |col|
      row = 1
      @board[row][col] = Pawn.new([row, col], :black)
      row = 6
      @board[row][col] = Pawn.new([row, col], :white)
    end

    # Place other pieces
    @board[0][0] = Rook.new([0, 0], :black)
    @board[0][7] = Rook.new([0, 7], :black)
    @board[0][1] = Knight.new([0, 1], :black)
    @board[0][6] = Knight.new([0, 6], :black)
    @board[0][2] = Bishop.new([0, 2], :black)
    @board[0][5] = Bishop.new([0, 5], :black)
    @board[0][3] = Queen.new([0, 3], :black)
    @board[0][4] = King.new([0, 4], :black)
    @board[7][0] = Rook.new([7, 0], :white)
    @board[7][7] = Rook.new([7, 7], :white)
    @board[7][1] = Knight.new([7, 1], :white)
    @board[7][6] = Knight.new([7, 6], :white)
    @board[7][2] = Bishop.new([7, 2], :white)
    @board[7][5] = Bishop.new([7, 5], :white)
    @board[7][3] = Queen.new([7, 3], :white)
    @board[7][4] = King.new([7, 4], :white)
  end

  def valid_move?(move_pos, side)
    true # TODO
  end

  def to_s
    puts '   a b c d e f g h'
    puts '  ' + '                 '.bg_cyan
    @board.each_with_index do |row_array, i|
      display = []

      row_array.each do |grid|
        grid.nil? ? display << '*'.blue.bg_cyan : display << grid
      end

      puts "#{ BOARD_SIZE - i } " + ' '.bg_cyan + \
        "#{ display.join(' '.bg_cyan) }" + ' '.bg_cyan + " #{ BOARD_SIZE - i }"
    end
    puts '  ' + '                 '.bg_cyan
    puts '   a b c d e f g h'
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
    @side == :white ? 'P'.bold.gray.bg_cyan : 'P'.bold.black.bg_cyan
  end
end

class Rook < Piece
  def initialize(pos, side)
    super(pos, side)
  end

  def to_s
    @side == :white ? 'R'.bold.gray.bg_cyan : 'R'.bold.black.bg_cyan
  end
end

class Knight < Piece
  def initialize(pos, side)
    super(pos, side)
  end

  def to_s
  @side == :white ? 'K'.bold.gray.bg_cyan : 'K'.bold.black.bg_cyan
  end
end

class Bishop < Piece
  def initialize(pos, side)
    super(pos, side)
  end

  def to_s
    @side == :white ? 'B'.bold.gray.bg_cyan : 'B'.bold.black.bg_cyan
  end
end

class Queen < Piece
  def initialize(pos, side)
    super(pos, side)
  end

  def to_s
    @side == :white ? 'Q'.bold.gray.bg_cyan : 'Q'.bold.black.bg_cyan
  end
end

class King < Piece
  def initialize(pos, side)
    super(pos, side)
  end

  def to_s
    @side == :white ? 'O'.bold.gray.bg_cyan : 'O'.bold.black.bg_cyan
  end
end

class HumanPlayer
  def initialize(game, side)
    @game, @side = game, side
  end

  def human_input_converter(human_input)
    human_input_array = human_input.split(',')

    human_input_array.map do |input|
      [BOARD_SIZE - input[1], input[0].ord - 97]
    end
  end

  def good_format?(string)
    size_verify   = string.size == 5
    letter_verify = regex_indices(string, /[a-h]/) == [0, 3]
    number_verify = regex_indices(string, /[1-8]/) == [1, 4]
    comma_verify  = string[2] == ','

    return false unless letter_verify && number_verify \
                        && comma_verify && size_verify
    true
  end

  def make_move
    valid_input = false
    until valid_input
      p @game.board
      print "What's your move? ex. a1,a2 : "
      human_input = gets.chomp.downcase.gsub(/\s+/, "")

      move_pos = human_input_converter(human_input)
      valid_input = good_format?(human_input) && valid_move?(move_pos, @side)

      puts 'Invalid input, please try again' unless valid_input
    end
  end

  def valid_move?(move_pos, side)
    @game.valid_move?(move_pos, side)
  end

  # Helper methods
  def regex_indices(string, regex)
    indices = []

    i = 0

    while i < string.size
      return indices if string.index(regex, i).nil?
      found_index = string.index(regex, i)
      indices << found_index
      i = found_index + 1
    end

    indices
  end
end

# Colors for Strings found here:
# http://stackoverflow.com/questions/1489183/colorized-ruby-output
class String
  def black;          "\033[30m#{self}\033[0m" end
  def blue;           "\033[34m#{self}\033[0m" end
  def gray;           "\033[37m#{self}\033[0m" end
  def bg_cyan;        "\033[46m#{self}\033[0m" end
  def bold;           "\033[1m#{self}\033[22m" end
end

if __FILE__ == $PROGRAM_NAME
  c = Chess.new
  c.play
end
