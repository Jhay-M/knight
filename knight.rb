def knight_moves(start, last)
  result = Board.new(start, last)
  result.tree
end

class Board
  attr_accessor :root, :final, :visited, :tree

  def initialize(start, final)
    @root = make_node(start)
    @final = final
    @visited = [start]
    @tree = make_tree
  end

  def make_tree(queue = [root])
    current = queue[0]
    return trace(current) if current.arr == final

    current.options.each do |item|
      next if visited.include?(item)

      current_child = make_node(item)
      current_child.parent = current
      current.children << current_child
      queue << current_child
      visited << current_child.arr
    end
    queue.shift
    make_tree(queue)
  end

  def trace(node, counter = 0, arr = [])
    arr << node.arr
    return display_result(arr.reverse, counter) if node == root

    trace(node.parent, counter + 1, arr)
  end

  def display_result(arr, int)
    puts "You made it in #{int} moves!  Here's your path:"
    arr.each { |x| p x }
  end

  def make_node(arr)
    Node.new(arr)
  end

  def invalid?(var1, var2)
    var1 < 0 || var1 > 7 || var2 < 0 || var2 > 7
  end

  def moves(arr)
    new_arr = [[-2, -1], [-2, 1], [-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2]]
    possible_moves = new_arr.map do |num1, num2|
      [arr[0] + num1, arr[1] + num2]
    end
    possible_moves.reject { |x, y| invalid?(x, y) }
  end
end

class Node < Board
  attr_accessor :arr, :children, :options, :parent

  def initialize(arr)
    @arr = arr
    @children = []
    @options = moves(arr)
    @parent = nil
  end
end

p knight_moves([3, 3], [0, 0])
