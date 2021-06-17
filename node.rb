# frozen_string_literal: true

# A node for a binary search tree. Contains the node's data and
# pointers to the left and right elements of the tree.
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    data <=> other.data
  end
end
