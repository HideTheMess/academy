class TreeNode
  attr_accessor :parent, :left_child, :right_child

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
    # p @left_child
    # nil
    set_child(self, left_child, 'left')
    # p @left_child
    # nil
  end

  def right=(right_child)
    set_child(self, right_child, 'right')
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

  def set_child(parent, new_child, side)
    if side == 'left'
      p "#{ parent.left_child.nil? ? 'nil' : parent.left_child.value } #{ new_child.value }"
      disown_child(parent.left_child)
      parent.left_child = new_child
      p "#{ parent.left_child.nil? ? 'nil' : parent.left_child.value } #{ new_child.value }"
      new_child.parent = self
    elsif side == 'right'
      p "#{ parent.right_child.nil? ? 'nil' : parent.right_child.value } #{ new_child.value }"
      disown_child(parent.right_child)
      parent.right_child = new_child
      p "#{ parent.right_child.nil? ? 'nil' : parent.right_child.value } #{ new_child.value }"
      new_child.parent = self
    end
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
