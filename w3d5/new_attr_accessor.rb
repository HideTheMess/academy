class Object
  def new_attr_accessor(*args)
    args.map! do |arg|
      unless arg.is_a?(String) || arg.is_a?(Symbol)
        raise TypeError.new "#{arg} is not a symbol"
      end

      arg.to_sym
    end

    args.each do |arg|
      # Define Getter
      define_method(arg) do
        instance_variable_get("@#{arg}")
      end

      # Define Setter (and Forgetter)
      define_method("#{arg}=") do |param|
        instance_variable_set("@#{arg}", param)
      end
    end

    nil
  end
end
