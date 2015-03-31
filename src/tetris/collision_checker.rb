require_relative '../settings'
require_relative '../point2f'

# states:
#   bounded: cannot move any further sidewards (left, right)
#   grounded: either floor hit or another already placed shape
#   moveable: next update does not result in a collision

class CollisionChecker

  #include Settings

  attr_reader :state

  # Check whether current movement was legal.
  # If issue was present, determines what kind of issue was present.
  #
  # @param shape [Shape] to check whether it collides with its map.
  # @param opertaion [Symbol] what operation was performed on shape.
  #        is either equal to :rotate or :move
  # @param shift [Point2f] relative shift amount. Only defined for :move operations.
  def initialize(shape, opertaion, shift = Point2f.new(0,0))
    @state = :moveable

    if opertaion == :rotate
      next_rot_hit_points = shape.next_rotation_position.map do |point|
        Point2f.new(point.x + shape.origin.x + 1, point.y + shape.origin.y + 1)
      end

      has_collision = next_rot_hit_points.any? do |pos|
        field = shape.grid_map.field_at(pos.x, pos.y)
        (field.floor? || field.placed? || field.border?)
      end
      @state = :bounded if has_collision

    elsif opertaion == :move
      next_move_hit_points = shape.next_translated_shape(shift)

      hit_ground = next_move_hit_points.any? do |pos|
         field = shape.grid_map.field_at(pos.x, pos.y)
          (field.floor? || field.placed?) == true
      end

      if(hit_ground)
        @state = :grounded
        shape.mark_fields_placed
        shape.apply_combo_check
      end

    elsif opertaion == :move_sidewards
      next_shape_state_positions = shape.next_translated_shape(shift)

      # check whether one cell of the new shape location produces a collision.
      has_collision = next_shape_state_positions.any? do |pos|
        field = shape.grid_map.field_at(pos.x, pos.y)
        (field.border? || field.placed?)
      end
      @state = :bounded if has_collision

    else
      raise "unknown shape operation"
    end

  end

  # Did collision detector detected a collision?
  # @return [Boolean] :true if there was a collision and :false otherwise.
  def blocked?
    state != :moveable
  end

end