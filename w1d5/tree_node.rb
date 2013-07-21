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
    disown_child(@left_child)
    @left_child = left_child
    left_child.parent = self
  end

  def right=(right_child)
    disown_child(@right_child)
    @right_child = right_child
    right_child.parent = self
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

  # Search Algorithms
  def dfs(search_value)
    return self if value == search_value

    left.nil? ? left_side = nil : left_side = left.dfs(search_value)
    return left_side unless left_side.nil?
    right.nil? ? nil : right_side = right.dfs(search_value)
  end

  def bfs(search_value, current_nodes = [self])
    current_nodes.each { |node| return node if node.value == search_value }

    next_nodes = []
    current_nodes.each do |node|
      next_nodes << node.left unless node.left.nil?
      next_nodes << node.right unless node.right.nil?
    end

    bfs(search_value, next_nodes)
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

end

if __FILE__ == $PROGRAM_NAME
  a = TreeNode.new('A')
  b = TreeNode.new('B')
  c = TreeNode.new('C')
  d = TreeNode.new('D')
  e = TreeNode.new('E')
  f = TreeNode.new('F')
  g = TreeNode.new('G')
  a.left = b
  a.right = c
  b.left = d
  b.right = e
  c.left = f
  c.right = g
  p a.bfs('A')
  p a.bfs('B')
  p a.bfs('C')
  p a.bfs('D')
  p a.bfs('E')
  p a.bfs('F')
  p a.bfs('G')
end
