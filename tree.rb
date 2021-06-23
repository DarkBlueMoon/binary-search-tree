# frozen_string_literal: true

require_relative 'node'
require 'pry'

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

  def insert(value, node = @root)
    return Node.new(value) if node.nil?
    return node if node.data == value

    if value > node.data
      node.right = insert(value, node.right)
    elsif value < node.data
      node.left = insert(value, node.left)
    end

    node
  end

  def delete(value, root = @root)
    return root if root.nil? # Tree is empty or node is not found.

    # Find the root we want to delete, if it exists.
    if value > root.data
      root.right = delete(value, root.right)
    elsif value < root.data
      root.left = delete(value, root.left)
    else
      # Node w/ only one child or no children
      return root.right if root.left.nil?
      return root.left if root.right.nil?

      temp = find_min(root.right)
      root.data = temp.data
      root.right = delete(temp.data, root.right)
    end
    root
  end

  def find_min(node)
    current = node
    current = current.left until current.left.nil?
    current
  end

  def find(value, node = @root)
    return node if node.data == value
    return nil if node.nil?
    return find(value, node.left) if value < node.data
    return find(value, node.right) if value > node.data
  end

  # Traverse the tree in breadth-first order, returning an array of values. (iterative)
  def level_order_iter
    visited = []
    discovered = []
    discovered << root

    until discovered.empty?
      current = discovered.shift
      visited << current.data
      discovered << current.left unless current.left.nil?
      discovered << current.right unless current.right.nil?
    end

    visited
  end

  # def level_order_recursive(node = @root, visited = [], discovered = [])
  #   return if node.nil?

  #   discovered << node

  #   visited
  # end

  # Traverse the tree in preorder depth-first order, returning an array of values. (root, left, right)
  def preorder(node = @root, arr = [])
    return if node.nil?

    arr << node.data
    # print "#{node.data} "
    preorder(node.left, arr)
    preorder(node.right, arr)

    arr
  end

  # Traverse the tree in inorder depth-first order, returning an array of values. (left, root, right)
  def inorder(node = @root, arr = [])
    return if node.nil?

    inorder(node.left, arr)
    arr << node.data
    inorder(node.right, arr)

    arr
  end

  # Traverse the tree in postorder depth-first order, returning an array of values. (left, right, root)
  def postorder(node = @root, arr = [])
    return if node.nil?

    postorder(node.left, arr)
    postorder(node.right, arr)
    arr << node.data

    arr
  end

  def height(node_val, node = find(node_val))
    return if node.nil?

    ret = 0

    until node.left.nil?
      node = node.left
      ret += 1
    end
    until node.right.nil?
      node = node.right
      ret += 1
    end

    ret
  end

  # def depth(node_val, node = find(node_val))
  #   return if node.nil?

  #   ret = 0


  # end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 5, 7, 9, 67, 6345, 324, 3])
tree.pretty_print
p tree.height(324)
# p tree.level_order_iter
# p tree.preorder
# p tree.inorder
# p tree.postorder
