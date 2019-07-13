require_relative "./poly_tree_node/lib/00_tree_node.rb"

class KnightPathFinder
    def initialize(start_pos)
        @root_node = PolyTreeNode.new(start_pos)
        @considered_positions = [start_pos]
    end

    def build_move_tree
       #start with root node?
        @root_node
    end

    def self.valid_moves(pos)

    end

    def new_move_positions(pos)
        current_valid_moves = KnightPathFinder.valid_moves(pos)
        current_valid_moves.reject! { |position| @considered_positions.include?(position) }
    end
end