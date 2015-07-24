require_relative 'segment'

# A snake is a doubly linked list of segment instances
# with to special segments: the head and the tail.
class Snake

  def initialize(pos)
   @head = Segment.new(pos)
   @tail = @head
   @cursor = @head
   @segments = [@head]
  end

  def head
    @head
  end

  def tail
    @tail
  end

  def move_by(delta)
    new_pos = @head.position.copy.add(delta)
    @head.update_and_propagate_by(new_pos)
  end

  def append_segment
    segment = Segment.new
    @segments << segment
    @tail.child = segment
    segment.parent = @tail
    @tail = segment
  end

  def positions
    @segments.map &:position
  end

end
