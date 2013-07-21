require 'set'

class WordChain
  attr_reader :dictionary, :start, :finish

  def initialize(start, finish)
    @dictionary = Set.new(File.readlines('dictionary.txt').map do |entry|
      entry.chomp.to_sym
    end)
    @start = start.to_sym
    @finish = finish.to_sym
  end

  def find_chain(start_word, end_word, dictionary)
    start_word = start_word.to_sym
    end_word = end_word.to_sym
    current_words = [start_word]
    visited_words = { start_word => nil }.merge({ rude: nil })
    new_words = []

    until current_words.empty?
      new_words = collect_next_words(current_words, visited_words, dictionary)
      current_words = new_words

      if new_words.include?(end_word)
        build_chain(visited_words, end_word)
        return
      else
        current_words = new_words
      end

    end
  end

  def build_chain(visited_words, word)
    chain = []

    until word.nil?
      chain.unshift(word)
      word = visited_words[word]
    end
    p chain.join(' => ')
  end

  # Helper methods
  def adjacent_words(word, dictionary)
    candidates = []

    word.length.times do |i|
      word_dup = word.to_s.dup

      ('a'..'z').to_a.each do |char|
        next if word[i] == char
        word_dup[i] = char

        candidates << word_dup.to_sym if @dictionary.include?(word_dup.to_sym)
      end
    end

    candidates
  end

  def collect_next_words(current_words, visited_words, dictionary)
    next_words = []
    next_visited = {}

    current_words.each do |word|
      next_words += adjacent_words(word, dictionary)
      next_words.delete_if { |el| visited_words.has_key?(el) }
      next_words.each do |el|
        next_visited[el] = word unless next_visited.include?(el)
      end
    end

    visited_words.merge!(next_visited)
    next_words
  end
end

if __FILE__ == $PROGRAM_NAME
  w = WordChain.new(:duck, :ruby)
  # p w.adjacent_words(:duck, w.dictionary)
  # p w.collect_next_words(["fuse", "muse", "rise", "rose", "rube", "rude", "rule", "rune", "rush", "rusk", "rust"], { 'duck' => nil }, w.dictionary)
  w.find_chain('duck', w.finish, w.dictionary)

end
