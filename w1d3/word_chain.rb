class WordChain
  attr_reader :start_str, :finish_str, :dictionary

  def initialize(args_arry)
    @start_str = args_arry[0]
    @finish_str = args_arry[1]
    get_dictionary
  end

  def find_chain(start_word, end_word, dictionary)
    current_words = [start_word]
    new_words = []
    visited_words = []

    new_words = adjacent_words(start_word, @dictionary)
    return new_words if new_words.empty?
    return [start_word] if new_words.include?(@finish_str)
    @dictionary.delete_if { |entry| new_words.include?(entry) }
    new_words.each do |word|
      winrar = find_chain(word, @finish_str, @dictionary)
      return winrar + [start_word] unless winrar.empty?
    end

    []
  end

  private

  def adjacent_words(word, dictionary) # Helper
    dictionary.select { |entry| adjacent?(word, entry) }
  end

  def adjacent?(word1, word2)
    arry1, arry2 = word1.split(''), word2.split('')
    diff_count = 0

    arry1.each_with_index do |char, i|
      diff_count += 1 unless char == arry2[i]
    end
    diff_count == 1
  end

  def get_dictionary
    @dictionary = File.readlines('dictionary.txt').map { |word| word.chomp }
    @dictionary = prune_dictionary
  end

  def prune_dictionary
    @dictionary.select { |word| word.length == @start_str.length }
  end
end

chain = WordChain.new(ARGV)
#p chain.find_chain(chain.start_str, chain.finish_str, chain.dictionary)
