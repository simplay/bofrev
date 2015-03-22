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
      next_rot_hit_points = shape.next_rotation_position.map do |point|
        Point2f.new(point.x + shape.origin.x + 1, point.y + shape.origin.y + 1)
      end

      puts next_rot_hit_points


      has_collision = next_rot_hit_points.any? do |pos|
        shape.grid_map.field_at(pos.x, pos.y).border? == true
      end

      if has_collision
        puts("rotation collision detected")
        @state = :bounded
      end


    elsif opertaion == :move

    else
      raise "unknown shape operation"
    end


  end

  def blocked?
    state != :moveable
  end

end