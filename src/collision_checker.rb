# states:
#   bounded: cannot move any further sidewards (left, right)
#   grounded: either floor hit or another already placed shape
#   moveable: next update does not result in a collision

class CollisionChecker

  attr_reader :state

  # Check whether current movement was legal.
  # @param grid [Array] game map grid before update
  # @param delta [Shape] shape state after translation/rotation
  def initialize(grid, delta, opertaion, amount = nil)
    @state = :moveable
  end

  def blocked?
    state != :moveable
  end

end