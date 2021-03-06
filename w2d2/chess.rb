BOARD_SIZE = 8

class Game
  def initialize
    @board = Board.new
  end

  def valid_move?(move_pos, player_side)
    @board.valid_move?(move_pos, player_side)
  end
end

class Chess < Game
  attr_reader :board # Unknown who needs this
  attr_reader :white, :black # Debug

  def initialize
    @board = ChessBoard.new
  end

  def play
    @board.place_pieces

    @white = HumanPlayer.new(self, :white)
    @black = HumanPlayer.new(self, :black)

    player_toggle = true
    # while false # While the game is still on # Debug
      if player_toggle
        begin
          move_pos = @white.make_move
        rescue ArgumentError
        rescue Over9000Error
        retry
        end

        @board.move_pieces(move_pos)
        player_toggle = false
      else
        begin
          move_pos = @black.make_move
        rescue ArgumentError
        rescue Over9000Error
        retry
        end

        @board.move_pieces(move_pos)
        player_toggle = true
      end
    # end
  end
end

class Board
  attr_reader :board # Piece(s) need this
  attr_reader :god_mode # Piece(s) & HumanPlayer need this

  def initialize
    @board = create_board
    @god_mode = false
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

class ChessBoard < Board
  def move_pieces(move_pos) # TODO

  end

  def place_pieces
    # Place pawns
    BOARD_SIZE.times do |col|
      row = 1
      @board[row][col] = Pawn.new(:black)
      row = 6
      @board[row][col] = Pawn.new(:white)
    end

    # Place other pieces
    @board[0][0] = Rook.new(:black)
    @board[0][7] = Rook.new(:black)
    @board[0][1] = Knight.new(:black)
    @board[0][6] = Knight.new(:black)
    @board[0][2] = Bishop.new(:black)
    @board[0][5] = Bishop.new(:black)
    @board[0][3] = Queen.new(:black)
    @board[0][4] = King.new(:black)
    @board[7][0] = Rook.new(:white)
    @board[7][7] = Rook.new(:white)
    @board[7][1] = Knight.new(:white)
    @board[7][6] = Knight.new(:white)
    @board[7][2] = Bishop.new(:white)
    @board[7][5] = Bishop.new(:white)
    @board[7][3] = Queen.new(:white)
    @board[7][4] = King.new(:white)
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
  attr_reader :side # Needed to detect potential enemy's side

  def initialize(side)
    @side = side
  end
end

class Pawn < Piece
  def initialize(side)
    super(side)
  end

  def valid_move?(move_pos, player_side, board)
    true # TODO
  end

  def to_s
    @side == :white ? 'P'.bold.gray.bg_cyan : 'P'.bold.black.bg_cyan
  end
end

class Rook < Piece
  def initialize(side)
    super(side)
  end

  def valid_move?(move_pos, player_side, board)
    true # TODO
  end

  def to_s
    @side == :white ? 'R'.bold.gray.bg_cyan : 'R'.bold.black.bg_cyan
  end
end

class Knight < Piece
  def initialize(side)
    super(side)
  end

  def valid_move?(move_pos, player_side, board)
    true # TODO
  end

  def to_s
  @side == :white ? 'K'.bold.gray.bg_cyan : 'K'.bold.black.bg_cyan
  end
end

class Bishop < Piece
  def initialize(side)
    super(side)
  end

  def valid_move?(move_pos, player_side, board)
    true # TODO
  end

  def to_s
    @side == :white ? 'B'.bold.gray.bg_cyan : 'B'.bold.black.bg_cyan
  end
end

class Queen < Piece
  def initialize(side)
    super(side)
  end

  def valid_move?(move_pos, player_side, board)
    true # TODO
  end

  def to_s
    @side == :white ? 'Q'.bold.gray.bg_cyan : 'Q'.bold.black.bg_cyan
  end
end

class King < Piece
  def initialize(side)
    super(side)
  end

  def valid_move?(move_pos, player_side, board)
    true # TODO
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
      [BOARD_SIZE - input[1].to_i, input[0].ord - 97]
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
    move_pos = []
      p @game.board
      puts "#{@side.to_s.capitalize} player's turn"
      print "What's your move? ex. a1,a2 : "
      human_input = gets.chomp.gsub(/\s+/, "")

      if human_input == 'Ned' # God Mode
        @game.board.toggle_god_mode
        raise Over9000Error.new \
          "God Mode is now #{@game.board.god_mode ? 'ON' : 'OFF'}"
      end

      human_input = human_input.downcase

      unless good_format?(human_input)
        raise ArgumentError.new 'Bad input format; please follow the example'
      end

      move_pos = human_input_converter(human_input)
      unless valid_move?(move_pos, @side)
        raise ArgumentError.new 'Move not allowed; please follow game rules'
      end

    move_pos
  end

  def valid_move?(move_pos, player_side)
    @game.valid_move?(move_pos, player_side)
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

class Over9000Error < ArgumentError
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

def debug
  c = Chess.new
  c.play
  # c.white.make_move
end

if __FILE__ == $PROGRAM_NAME
  c = Chess.new
  c.play
end
