# frozen_string_literal: true

require_relative 'node'

# A Balanced BST class.
class Tree
  attr_accessor :root

  def initialize(arr)
    sorted = arr.uniq.sort
    @root = build_tree(sorted, 0, sorted.size - 1)
  end

  def build_tree(arr, start_idx, end_idx)
    return nil if start_idx > end_idx # base case

    # Get the middle element and make it root
    mid = (start_idx + end_idx) / 2
    root = Node.new(arr[mid])

    # Calculate mid of left subarray and make it root of left subtree
    root.left = build_tree(arr, start_idx, mid - 1)
    # Calculate mid of right subarray and make it root of right subtree
    root.right = build_tree(arr, mid + 1, end_idx)

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
puts tree.pretty_print
