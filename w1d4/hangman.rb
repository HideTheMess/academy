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
    until tries > MAX_TRIES || won?
      guess = @guesser.guess_letter(@board, tries)
      @referee.check_board(@board, tries, guess)
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

  def check_board(board, tries, guess)
    print "Is '#{ guess }' in your word? (y/n) "
    answer = gets[0].downcase

    if answer == 'y'
      print "Which positions is '#{guess}'? (comma separated) "
      positions = gets.chomp.split(',')
      positions.each { |pos| board[pos] = guess }
    else
      tries += 1
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
  def guess_letter(board, tries)
    guess = ('a'..'z').to_a.sample
    puts "Secret word: #{ board.join(' ') }"
    puts "Tries left: #{ MAX_TRIES - tries }"
    puts "Computer guesses '#{ guess }'\n"
    guess
  end

  def check_board(board, tries, guess)
    if @word.include?(guess)

      @word.split('').each_with_index do |char, i|
        board[i] = guess if @word[i] == char
      end
      p board

    else
      tries += 1
    end
  end

  def word_length
    dictionary = File.readlines('dictionary.txt').map(&:chomp)
    @word = dictionary.sample
    @word.length
  end
end

if __FILE__ == $PROGRAM_NAME
  referee = ComputerPlayer.new
  guesser = ComputerPlayer.new
  h = Hangman.new(referee, guesser)
  h.play
end
