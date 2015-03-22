require_relative 'settings'

# states:
#   bounded: cannot move any further sidewards (left, right)
#   grounded: either floor hit or another already placed shape
#   moveable: next update does not result in a collision

class CollisionChecker

  attr_reader :state

  # Check whether current movement was legal.
  # If issue was present, determines what kind of issue was present.
  #
  # @param shape [Shape] to check whether it collides with its map.
  # @param opertaion [Symbol] what operation was performed on shape.
  #        is either equal to :rotate or :move
  # @param shift [Point2f] relative shift amount. Only defined for :move operations.
  def initialize(shape, opertaion, shift = nil)
    @state = :moveable
    #sc_shape = shape.shallow_copy
    if opertaion == :rotate
      #rotated_positions = sc_shape.rotate.points_in_grid_coords

    elsif opertaion == :move

    else
      raise "unknown shape operation"
    end


  end

  def blocked?
    state != :moveable
  end

end