require_relative "node"

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


  def preorder(node = @root)
    return if node.nil?
    temp = []
    temp << node.data
    temp << preorder(node.left)
    temp << preorder(node.right)
    temp.flatten.compact
  end

  def inorder(node = @root)
    return if node.nil?
    temp = []
    temp << inorder(node.left)
    temp << node.data
    temp << inorder(node.right)
    temp.flatten.compact
  end

  def postorder(node = @root)
    return if node.nil?
    temp = []
    temp << postorder(node.left)
    temp << postorder(node.right)
    temp << node.data
    temp.flatten.compact
  end
  
  def traverse(data, node)
    temp = node
    data < temp.data ? temp = temp.left : temp = temp.right
    temp
  end

  def insert(data, node = @root)
    temp = node
    loop do
      temp = traverse(data, temp)
      break if traverse(data, temp).nil?
    end
    data < temp.data ? temp.left = Node.new(data) : temp.right = Node.new(data)
  end

  
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new
tree.root = tree.build_tree([20, 19, 3, 145, 67, 98, 8, 56])
