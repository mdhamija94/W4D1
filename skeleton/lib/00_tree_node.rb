require "byebug"

class PolyTreeNode
    attr_reader :parent, :children, :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def inspect
        {'value' => @value}.inspect
        # , 'parent' => @parent, 'children' => @children}.inspect
    end

    def parent=(node)
        # debugger
        if self.parent.nil?
            @parent = node
            parent.children << self
        else
            orig_parent = self.parent
            orig_parent.children.delete(self)
            @parent = node
            parent.children << self unless parent.nil?
        end
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        if child_node.parent == nil
            raise "this is not a kid"
        end
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
        #push unshift
        # return self if self.value == target
        # debugger
        queue = [self]

        until queue.empty?
           ele = queue.shift
           return ele if ele.value == target
           ele.children.each { |child| queue << child }
        end
        
        nil
    end
end