class Node
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def build_tree(arr, start = 0, finish = arr.length - 1)
    return nil if start > finish

    arr = arr.sort
    mid = (start + finish) / 2
    node = Node.new(arr[mid])
    node.left = build_tree(arr, start, mid - 1)
    node.right = build_tree(arr, mid + 1, finish)
    node
  end

  def pre_order(node)
    return if node.nil?

    print "#{node.data} "
    pre_order(node.left)
    pre_order(node.right)
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new
tree.root = tree.build_tree([20, 19, 3, 145, 67, 98, 8, 56])
puts 'pre-order traversal of constructed BST'
tree.pre_order(tree.root)
tree.pretty_print
