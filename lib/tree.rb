require_relative "node"

class Tree 
    attr_accessor :root

    def initialize
        @root = nil
    end

    def build_tree (array, start = 0, finish = array.size-1)
        return nil if start > finish
        array = array.uniq.sort
        mid = (start + finish)/2
        @root = Node.new(array[mid])
        @root.left = build_tree(array, start, mid-1)
        @root.right = build_tree(array, mid+1, finish)
        @root
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end