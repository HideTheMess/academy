class TreeNode
  attr_writer :parent

  def initialize(value = nil)
    @value = value
    @parent = nil
    @left_child = nil
    @right_child = nil
  end

  def parent
    @parent
  end

  # Setters
  def left=(left_child)
    p @left_child
    # nil
    set_child(@left_child, left_child)
    p @left_child
    # nil
  end

  def right=(right_child)
    set_child(@right_child, right_child)
  end

  def value=(value)
    @value = value
  end

  # Getters
  def left
    @left_child
  end

  def right
    @right_child
  end

  def value
    @value
  end

  private

  def to_s
    "Value: \t#{ @value.nil? ? 'nil' : value }\n" + \
    "Parent:\t#{ @parent.nil? ? 'nil' : @parent.value }\n" + \
    "Left: \t#{ @left_child.nil? ? 'nil' : @left_child.value }\n" + \
    "Right: \t#{ @right_child.nil? ? 'nil' : @right_child.value }\n"
  end

  def disown_child(child)
    child.parent = nil unless child.nil?
  end

  def set_child(child_side, new_child)
    p "#{ child_side.nil? ? 'nil' : child_side.value } #{ new_child.value }"
    disown_child(child_side)
    p "#{ child_side.nil? ? 'nil' : child_side.value } #{ new_child.value }"
    child_side = new_child
    p "#{ child_side.nil? ? 'nil' : child_side.value } #{ new_child.value }"
    new_child.parent = self
    p "#{ child_side.nil? ? 'nil' : child_side.value } #{ new_child.value }"
  end
end

if __FILE__ == $PROGRAM_NAME
  a = TreeNode.new('A')
  b = TreeNode.new('B')
  c = TreeNode.new('C')
  a.left = b
  # nil
#   "nil B"
#   "nil B"
#   "B B"
#   "B B"
#   nil
  p a
  # Value:   A
#   Parent:  nil
#   Left:   nil
#   Right:   nil
  p b
  # Value:   B
#   Parent:  A
#   Left:   nil
#   Right:   nil
  a.left = c
  # nil
#   "nil C"
#   "nil C"
#   "C C"
#   "C C"
#   nil
  p a
  # Value:   A
#   Parent:  nil
#   Left:   nil
#   Right:   nil
  p b
  # Value:   B
#   Parent:  A
#   Left:   nil
#   Right:   nil
  p c
  # Value:   C
#   Parent:  A
#   Left:   nil
#   Right:   nil
end
