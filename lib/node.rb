class Node
    attr_accessor :value, :left, :right

  include Comparable
  
    def initialize(value = nil, left = nil, right = nil)
      @value, @left, @right = value , left, right
    end
end