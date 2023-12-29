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

  def pre_order(node = @root, &block) #block doesn't work
    return if node.nil?

    temp = []
    temp << node.data
    temp << pre_order(node.left)
    temp << pre_order(node.right)
    block_given? ? temp.flatten.compact.each{|x| yield x} : temp.flatten.compact
  end

  def in_order(node = @root, &block) #block doesn't work
    return if node.nil?

    temp = []
    temp << in_order(node.left)
    temp << node.data
    temp << in_order(node.right)
    block_given? ? temp.flatten.compact.each{|x| yield x} : temp.flatten.compact
  end

  def post_order(node = @root, &block) #block doesn't work
    return if node.nil?

    temp = []
    temp << post_order(node.left)
    temp << post_order(node.right)
    temp << node.data
    block_given? ? temp.flatten.compact.each{|x| yield x} : temp.flatten.compact
  end

  def level_order(&block) #block doesn't work
    nil if @root.nil?
    queue = []
    array = []
    queue.push(@root)
    until queue.empty?
      block_given? ? (yield queue[0].data) : array.push(queue[0].data)
      queue.push(queue[0].left) unless queue[0].left.nil?
      queue.push(queue[0].right) unless queue[0].right.nil?
      queue.shift
    end
    array unless block_given?
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

  def find(data)
    temp = @root
    temp = traverse(data, temp) until temp.data == data || (temp.left.nil? && temp.right.nil?)
    temp
  end

  def depth(node)
    temp = @root
    counter = 0
    until temp.data == node.data
      temp = traverse(node.data, temp)
      counter +=1
    end
    counter
  end

  def height(node)
    depths = []
    array = in_order
     if node.data < @root.data
      array = array.select{|x| x < @root.data}
     else
      array = array.select{|x| x > @root.data}
     end
    array.each{|x| depths.push(depth(find(x)))}
    depths.max - depth(node)
  end

  def balanced?
    (height(@root.right) - height(@root.left)).abs < 2
  end

  def rebalance
    @root = build_tree(in_order)
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
