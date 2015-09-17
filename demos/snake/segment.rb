# Every Segment is an item at a certain position within a snake.
# A Segment can have a parent Segment and a child Segment.
class Segment
  attr_accessor :parent,  # Segment or nil
                :child,   # Segment or nil
                :position # Point2f

  def initialize(pos=nil)
    @position = pos
  end

  def update_and_propagate_by(pos)
    prev_pos = @position
    @position = pos
    child.update_and_propagate_by(prev_pos) if child?
  end

  def child?
    !@child.nil?
  end

end
