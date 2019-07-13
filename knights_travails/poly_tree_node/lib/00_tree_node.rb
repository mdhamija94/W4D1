class PolyTreeNode
    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def inspect
        {'value' => @value}.inspect
    end
    

    def parent=(new_parent)
        old_parent = self.parent
        old_parent.children.delete(self) unless old_parent.nil?

        @parent = new_parent

        new_parent.children << self unless new_parent.nil?
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "This is not a child node." if child_node.parent.nil?
        child_node.parent = nil
    end

    def dfs(target)
        return self if self.value == target
        
        self.children.each do |child|
            result = child.dfs(target)
            return result unless result.nil?
        end

        nil
    end

    def bfs(target)
        queue = [self]

        until queue.empty?
           ele = queue.shift
           return ele if ele.value == target
           queue.concat(ele.children)
        end
        
        nil
    end
end