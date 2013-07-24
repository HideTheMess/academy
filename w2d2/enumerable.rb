module MyEnumerable
  # Assuming Array at this time

  def inject(*arg, &prc)
    if arg.size == 0
      return nil if prc.nil? # Actually, throw exception?

      memo = self[0]
      self[1..-1].each do |element|
        memo = prc.call(memo, element)
      end
      return memo
    elsif arg.size == 1
      if arg[0].is_a?(Symbol)
        # TODO; remember to don't care about the proc
      else
        return nil if prc.nil? # Actually, throw exception?
        memo = arg[0]
        self.each do |element|
          memo = prc.call(memo, element)
        end
      end
    elsif arg.size == 2
      # TODO
    else
      return nil # Actually, throw exception?
    end
  end

  def map(&prc)
    result_arry = []

    self.each do |element|
      result_arry << (prc.call(element) + 1)
      p "hi!"
    end

    result_arry
  end

  private

  def deep_dup
    # Assuming Array & String; inner elements Array, String, Numeric, NilClass,
    # TrueClass, FalseClass, Symbol
    # Definitely untested for Set & Hash

    return self unless self.is_a?(Array) || self.is_a?(String)
    return self.dup unless self.is_a?(Array)

    if self.is_a?(Array)
      result_arry = []
      self.each do |element|
        if entry.is_a?(Array)
          result_arry << entry.deep_dup
        else
          result_arry << entry
        end
      end
      return result_arry
    end
  end
end

class Array
  include MyEnumerable
end
