require_relative '01_knight_path_finder'

class PolyTreeNode
  
  attr_reader :parent, :children, :value
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent=(parent_node)
    unless @parent == nil
      parents_children = self.parent.children
      parents_children.delete(self)
    end
    
    @parent = parent_node
    return nil if parent_node == nil
    
    unless parent_node.children.include?(self)
      parent_node.children.push(self)
    end
  end
  
  

  
  def add_child(child_node)
    self.children << child_node 
    child_node.parent = self 
  end
  
  def remove_child(child_node)
    if @children.include?(child_node)
      @children.delete(child_node)
    else
      raise "Child does not exist!"
    end
    child_node.parent = nil
  end 
  
  def dfs(target_value)
    return self if self.value == target_value
    @children.each do |child_node|
      search_node = child_node.dfs(target_value)
      return search_node unless search_node == nil
    end
    return nil
  end
  
  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift 
      if node.value == target_value
        return node
      else 
        node.children.each do |child_node|
          queue << child_node
        end 
      end 
    end
  end
  
end