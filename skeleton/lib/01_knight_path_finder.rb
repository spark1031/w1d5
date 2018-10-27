require_relative '00_tree_node'

class KnightPathFinder
    attr_reader :root_node
  
  def initialize(pos)
    @root_node = PolyTreeNode.new(pos)
    @visited_positions = [pos]
  
    
    self.build_move_tree #do we need to store this as an instance variable??
  end
  
  # returns an array of positions: new_move_positions(current.value)
  # iterate over my positions and make them into node objects (PolyTreeNode.new(pos)) - 
    # current_node.add_child(child_node)
    # shovel these node objects into queue array
    # set parent to current_node for each child_node
  def build_move_tree #take in @root_node as an argument - we have some logic that builds out all the possible positions
    queue = [@root_node]
    until queue.empty?
      current_node = queue.shift
      possible_positions = new_move_positions(current_node.value) #[]
      possible_positions.each do |position| #[1,2]
        child_node = PolyTreeNode.new(position) #node object(value = 1,2)
        child_node.parent = current_node
        current_node.add_child(child_node)
        queue << child_node
      end
    end
  end
  

  def self.valid_moves(pos) 
    pre_result = []
    (-2..2).each do |adder1|
      (-2..2).each do |adder2|
        if adder1 != 0 && adder2!= 0 && adder1.abs != adder2.abs
          pre_result << [pos.first + adder1, pos.last + adder2]
        end
      end
    end
    pre_result.select { |potential_pos| potential_pos.first.between?(0, 7) && potential_pos.last.between?(0, 7) }
  end
  
  #this calls ::valid_moves but filters out positions inside @visited_positions (it's an array)
  def new_move_positions(pos)
    all_moves = KnightPathFinder.valid_moves(pos)
    
    filtered_moves = all_moves - @visited_positions 
    @visited_positions += filtered_moves 
    return filtered_moves
  end 
  
  def find_path(end_pos)
    target_node = @root_node.bfs(end_pos)
    parent_node = target_node.parent 
    results = [target_node.value]
    
    until parent_node.nil? 
      results.unshift(parent_node.value)
      parent_node = parent_node.parent
    end 
    
    results 
  end 

end




