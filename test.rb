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

  def pre_order(node = @root, &block)
    return [] if node.nil?

    result = []
    result << node.data
    result += pre_order(node.left)
    result += pre_order(node.right)
    block_given? ? result.each { |x| yield x } : result
  end

  def in_order(node = @root, &block)
    return [] if node.nil?

    result = []
    result += in_order(node.left)
    result << node.data
    result += in_order(node.right)
    block_given? ? result.each { |x| yield x } : result
  end

  def post_order(node = @root, &block)
    return [] if node.nil?

    result = []
    result += post_order(node.left)
    result += post_order(node.right)
    result << node.data
    block_given? ? result.each { |x| yield x } : result
  end

  def level_order(&block)
    return [] if @root.nil?

    queue = [@root]
    result = []
    until queue.empty?
      node = queue.shift
      block_given? ? (yield node.data) : result << node.data
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
    result unless block_given?
  end
end
