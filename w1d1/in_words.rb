class Fixnum
  def in_words
    return 'zero' if self == 0
    num = self
    words = []

    if num >= 1000000000000
      words << under_1k_to_words(num / 1000000000000) + ' trillion'
      num %= 1000000000000
    end

    if num >= 1000000000
      words << under_1k_to_words(num / 1000000000) + ' billion'
      num %= 1000000000
    end

    if num >= 1000000
      words << under_1k_to_words(num / 1000000) + ' million'
      num %= 1000000
    end

    if num >= 1000
      words << under_1k_to_words(num / 1000) + ' thousand'
      num %= 1000
    end

    words << under_1k_to_words(num) if num > 0
    words.join(' ')
  end

  def under_1k_to_words(num)
    words = []
    words << digit_to_word(num / 100) + ' hundred' if num >= 100
    num %= 100

    if num >= 10 && num < 20
       words << teen_to_word(num)
       return words.join(' ')
    end

    words << ten_to_word(num - (num % 10)) if num >= 20
    num %= 10
    words << digit_to_word(num) if num > 0
    words.join(' ')
  end

  def digit_to_word(num)
    num_hash = {
      1 => 'one',
      2 => 'two',
      3 => 'three',
      4 => 'four',
      5 => 'five',
      6 => 'six',
      7 => 'seven',
      8 => 'eight',
      9 => 'nine'
    }
    num_hash[num]
  end

  def teen_to_word(num)
    num_hash = {
      10 => 'ten',
      11 => 'eleven',
      12 => 'twelve',
      13 => 'thirteen',
      15 => 'fifteen'
    }
    if num_hash.has_key?(num)
      return num_hash[num]
    else
      num %= 10
      return "#{digit_to_word(num)}teen"
    end
  end

  def ten_to_word(num)
    num_hash = {
      20 => 'twenty',
      30 => 'thirty',
      40 => 'forty',
      50 => 'fifty',
      80 => 'eighty',
    }
    if num_hash.has_key?(num)
      return num_hash[num]
    else
      num /= 10
      return "#{digit_to_word(num)}ty"
    end
  end
end
