# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/AbcSize
require_relative 'node'

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
    data < temp.data ? temp.left : temp.right
  end

  def insert(data, node = @root)
    temp = node
    loop do
      temp = traverse(data, temp)
      break if traverse(data, temp).nil?
    end
    data < temp.data ? temp.left = Node.new(data) : temp.right = Node.new(data)
  end

  def left?(data, node)
    !node.left.nil? && node.left.data == data
  end

  def right?(data, node)
    !node.right.nil? && node.right.data == data
  end

  def delete(data)
    # add a clause to return error if data doesn't exist
    # work in progress, also try using assigning grandchild_left, grandchild_right for cleaner code
    temp = @root
    temp = traverse(data, temp) until left?(data, temp) || right?(data, temp)
    child = traverse(data, temp)
    if child.left.nil? && child.right.nil?
      left?(data, temp) ? temp.left = nil : temp.right = nil
    elsif child.left.nil? && !child.right.nil?
      left?(data, temp) ? temp.left = child.right : temp.right = child.right
    elsif !child.left.nil? && child.right.nil?
      left?(data, temp) ? temp.left = child.left : temp.right = child.left
    else
      temp2 = child
      if left?(data, temp)
        temp.left = temp2.left
        temp.left.right = temp2.right
      else
        right?(data, temp)
        temp.right = temp2.left
        temp.right.right = temp2.right
      end
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new
tree.root = tree.build_tree([20, 19, 3, 145, 67, 98, 8, 56])
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
