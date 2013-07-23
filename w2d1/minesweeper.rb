class Minesweeper
  attr_reader :board

  def initialize(size, bomb_count)
    @board = make_board(size)
    @bomb_count = bomb_count
  end

  def display_board
  end

  def make_board(size)
    board = []

    size.times do |row|
      fill_array = []

      size.times do |col|
        fill_array << Tile.new(row, col, self)
      end

      board << fill_array
    end

    board
  end

  def place_bombs
    bomb_pos = []

    until bomb_pos.size == @bomb_count
      row, col = rand(@board.size), rand(@board.size)
      bomb_pos << [row, col] unless bomb_pos.include?([row, col])
    end

    bomb_pos.each do |row, col|
      @board[row][col].place_bomb
    end
  end

  def play
  end
end

class Tile
  @@DELTA = [ [ 1, -1],
    [ 1,  0], [ 1,  1],
    [ 0, -1], [ 0,  1],
    [-1, -1], [-1,  0],
    [-1,  1]]

  attr_reader :pos # Debug only

  def initialize(row, col, game)
    @pos = [row, col]
    @game = game
    @bomb, @flag, @revealed = false, false, false
  end

  def near_bomb_count
    @neighbors.inject(0) { |accum, neighbor| neighbor.bomb ? (accum + 1) : accum }
  end

  def neighbors
    return @neighbors unless @neighbors.nil?

    neighbor_coords = []

    @@DELTA.each do |d_row, d_col|
      neighbor_coords << [@pos[0] + d_row, @pos[1] + d_col]
    end

    neighbor_coords.delete_if do |row, col|
      row < 0 || row >= @game.board.size || col < 0 || col >= @game.board.size
    end

    @neighbors = neighbor_coords.map { |row, col| @game.board[row][col] }
  end

  def place_bomb
    @bomb = true
  end

  def toggle_flag
    return if @revealed
    @flag = !@flag
  end

  def to_s
    if @flag
      return 'P'
    elsif @bomb # Debug only
      return '*'
    elsif !@revealed # Not revealed
      return 'H'
    else
      no_bombs = bomb_count

      if no_bombs == 0
        return ' '
      else
        return no_bombs.to_s
      end
    end
  end
end
