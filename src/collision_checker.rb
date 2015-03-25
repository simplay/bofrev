require_relative 'settings'
require_relative 'point2f'

# states:
#   bounded: cannot move any further sidewards (left, right)
#   grounded: either floor hit or another already placed shape
#   moveable: next update does not result in a collision

class CollisionChecker

  include Settings

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

    if opertaion == :rotate
      next_rot_hit_points = shape.next_rotation_position.map do |point|
        Point2f.new(point.x + shape.origin.x + 1, point.y + shape.origin.y + 1)
      end

      has_collision = next_rot_hit_points.any? do |pos|
        shape.grid_map.field_at(pos.x, pos.y).border? == true
      end

      if has_collision
        @state = :bounded
      end

    elsif opertaion == :move
      next_origin = shape.next_moved_origin(shift)
      next_move_hit_points = shape.local_points.map do |point|
        Point2f.new(point.x + next_origin.x, point.y + next_origin.y)
      end

      has_collision = next_move_hit_points.any? do |pos|
        shape.grid_map.field_at(pos.x, pos.y).border? == true
      end

      @state = :bounded if has_collision

      unless has_collision
        hit_ground = next_move_hit_points.any? do |pos|
           field = shape.grid_map.field_at(pos.x, pos.y)
            (field.floor? || field.placed?) == true
        end

        if(hit_ground)
          @state = :grounded
          shape.mark_fields_placed
        end
      end

    else
      raise "unknown shape operation"
    end

  end

  def blocked?
    state != :moveable
  end

end