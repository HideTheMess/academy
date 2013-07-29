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