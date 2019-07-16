require_relative "./poly_tree_node/lib/00_tree_node.rb"
require "byebug"
class KnightPathFinder
    attr_accessor :considered_positions, :root_node

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
        # debugger
        build_move_tree
    end

    def build_move_tree
        queue = [@root_node]
       
        until queue.empty?
            node = queue.shift

            next_positions = new_move_positions(node.value)
            return "the end of the line" if next_positions.nil?
            next_positions.each do |pos| 
                next_node = PolyTreeNode.new(pos)
                queue << next_node
                node.add_child(next_node)
            end
        end
    end

    def self.valid_moves(pos)
        x, y = pos
        potential_moves = [ [x + 1, y + 2], [x + 2, y + 1],
                            [x - 2, y + 1], [x - 1, y + 2],
                            [x - 2, y - 1], [x - 1, y - 2],
                            [x + 2, y - 1], [x + 1 , y - 2]
                            ]

        min = 0
        max = 7

        potential_moves.select! do |new_pos|
            new_pos[0] >= min && new_pos[0] <= max && new_pos[1] >= min && new_pos[1] <= max
        end
    end

    def new_move_positions(pos)
        current_valid_moves = KnightPathFinder.valid_moves(pos)
        unless current_valid_moves.nil?
            current_valid_moves.reject! { |position| @considered_positions.include?(position) } 
            considered_positions.concat(current_valid_moves)
            return current_valid_moves
        end
    end

    def find_path(end_pos)
        debugger
        end_point = self.root_node.dfs(end_pos)
        trace_path_back(end_point).reverse
    end

    def trace_path_back(node)
        path = [node.value]
        queue = [node] 
        until queue.empty?
            el = queue.shift
            path << el.parent.value
            queue.concat(el.parent)
        end
        path
    end 
end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]
# knight = KnightPathFinder.new([0,0])
# p knight.find_path([3,3])
# first_gen = knight.root_node.children
# second_gen = []
# first_gen.each { |node| second_gen << node.children }
# p second_gen

# p KnightPathFinder.valid_moves([0,0])
# p knight.new_move_positions([0,0])
# p knight.considered_positions
# p knight.new_move_positions([4,4])