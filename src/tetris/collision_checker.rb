require_relative '../point2f'

# CollisionChecker Checks whether current shape movement was legal.
# If issue was present, determines what kind of issue was present.
# Collision state is stored in CollisionChecker#state.
#
# Detectable states:
#   + bounded: cannot move any further sidewards (left, right).
#   + grounded: either floor hit or another already placed shape.
#   + moveable: next update does not result in a collision.
class CollisionChecker

  attr_reader :state

  # @param shape [Shape] to check whether it collides with its map.
  # @param operation [Symbol] what operation was performed on shape.
  #        is either equal to :rotate or :move
  # @param shift [Point2f] relative shift amount. Only defined for :move operations.
  def initialize(shape, operation, shift = Point2f.new(0,0))
    @state = :moveable

    if operation == :rotate
      next_rot_hit_points = shape.next_rotated_shape

      has_collision = next_rot_hit_points.any? do |pos|
        conditions = [:floor?, :placed?, :border?]
        shape.grid_map.field_at(pos.x, pos.y).fulfills_any?(conditions)
      end
      @state = :bounded if has_collision

    elsif operation == :move
      next_move_hit_points = shape.next_translated_shape(shift)

      hit_ground = next_move_hit_points.any? do |pos|
        conditions = [:floor?, :placed?]
        shape.grid_map.field_at(pos.x, pos.y).fulfills_any?(conditions)
      end

      if hit_ground
        @state = :grounded
        shape.mark_fields_placed
        shape.apply_combo_check
      end

    elsif operation == :move_sidewards
      next_shape_state_positions = shape.next_translated_shape(shift)

      has_collision = next_shape_state_positions.any? do |pos|
        conditions = [:border?, :placed?]
        shape.grid_map.field_at(pos.x, pos.y).fulfills_any?(conditions)
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