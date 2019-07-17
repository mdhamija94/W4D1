require_relative "./poly_tree_node/lib/00_tree_node.rb"
require "byebug"

class KnightPathFinder
    attr_accessor :considered_positions, :root_node, :attr_pos

    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @pos = start_pos
        @considered_positions = [start_pos]
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
        [   [x + 1, y + 2], [x + 2, y + 1],
            [x - 2, y + 1], [x - 1, y + 2],
            [x - 2, y - 1], [x - 1, y - 2],
            [x + 2, y - 1], [x + 1 , y - 2] ]
    end

    def new_move_positions(pos)
        new_moves = KnightPathFinder.valid_moves(pos)
        
        new_moves.select! do |move| 
            !@considered_positions.include?(move) && move.none?{|el| el > 7 || el < 0}
        end 

        considered_positions.concat(new_moves)
        
        new_moves
    end

    def find_path(end_pos)
        trace_path_back(@root_node.dfs(end_pos))
    end

    def trace_path_back(node)
        return [@pos] if node == @root_node

        trace_path_back(node.parent) << node.value
    end 
end

kpf = KnightPathFinder.new([0, 0])
p kpf.find_path([7, 6]) # => [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
p kpf.find_path([6, 2]) # => [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]