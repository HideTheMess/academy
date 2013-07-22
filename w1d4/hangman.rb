MAX_TRIES = 10

class Hangman
  def initialize(referee, guesser)
    @referee = referee
    @guesser = guesser
  end

  def play
    # Ref gives word length
    @board = ['_'] * @referee.word_length

    tries = 0
    until tries >= MAX_TRIES || won?
      guess = @guesser.guess_letter(@board, tries)
      tries += 1 unless @referee.good_guess?(@board, guess)
    end

    if won?
      puts 'Good job'
      return
    end

    puts 'You lose'
  end

  def won?
    return true unless @board.include?('_')
    false
  end
end

class HumanPlayer
  def guess_letter(board, tries)
    puts "Secret word: #{ board.join(' ') }"
    puts "Tries left: #{ MAX_TRIES - tries }"
    print 'Guess a letter: '
    gets.chomp
  end

  def good_guess?(board, guess)
    print "Is '#{ guess }' in your word? (y/n) "
    answer = gets[0].downcase

    if answer == 'y'
      print "Which positions is '#{guess}'? (comma separated) "
      positions = gets.chomp.split(',')
      positions.each { |pos| board[pos.to_i] = guess }
      true
    else
      false
    end
  end

  def word_length
    word_length = 0

    until word_length.to_i > 0
      print 'How long is your word? '
      word_length = gets
      puts 'Your word length must be greater than zero' if word_length.to_i <= 0
    end

    word_length.to_i
  end
end

class ComputerPlayer
  def initialize
    @first_round = true
    @visited_chars = []
  end

  def guess_letter(board, tries)
    if @first_round
      @first_round = false
      @dictionary = File.readlines('dictionary.txt').map(&:chomp)
      @dictionary.select! { |entry| entry.length == board.length }
    end

    board.each_with_index do |char, i|
      next if char == '_'
      @dictionary.select! { |entry| entry[i] == char }
    end

    freq_hash = Hash.new(0)
    @dictionary.join('').each_char do |char|
      freq_hash[char] += 1
    end

    freq_hash.delete_if { |key| @visited_chars.include?(key) }
    guess = freq_hash.max_by { |k, v| v }[0]
    @visited_chars << guess

    puts "Secret word: #{ board.join(' ') }"
    puts "Tries left: #{ MAX_TRIES - tries }"
    puts "Computer guesses '#{ guess }'\n"
    guess
  end

  def good_guess?(board, guess)
    if @word.include?(guess)

      @word.split('').each_with_index do |char, i|
        board[i] = guess if @word[i] == guess
      end
      true

    else
      false
    end
  end

  def word_length
    dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @word = dictionary.sample
    @word.length
  end
end

if __FILE__ == $PROGRAM_NAME
  referee = HumanPlayer.new
  guesser = HumanPlayer.new
  h = Hangman.new(referee, guesser)
  h.play
end
