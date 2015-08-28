require 'point2f'
require_relative 'collision_checker'
require_relative 'tetris'
require 'game_field_type_constants'

# Shape encodes a collection of dependent cells that have to be placed in the game grid,
# using provided user inputs and game state updates.
#
# This is an abstract formulation of a concrete Shape. In order to define an own shape
# Inherit from this class and implement Shape#position_states
#
# Each shape has a special position called :origin that is a unique position in the game grid.
# This position is used in the game grid.
# Note that origin is used to define the zero position of locale shape coordinate system.
# When moving a shape in the grid, only its origin position is actually moved (down, left, right).
#
# The gestalt of a shape is given by a set of Point2f instance referenced in :local_points.
# Note that these points are in local shape coordinates with zero position given by :origin.
# Therefore, by simply adding the Point2f :origin to the Point2f configuration :local_points
# gives us the points locations in the game grid.
#
# For rotating a shape we ONLY have to modify (rotate) the point set :local_points.
# Instead of implementing a discrete rotation approach, we store all supported rotational
# configurations of a shape in an list called :position_states.
#
# Whenever we apply a rotation to a shape we simply pick the corresponding rotational
# configuration from that list. Only rotations by 90 degrees are supported, thus we
# have to store/define 4 rotational configurations for each shape.
#
# We can think of Shape#position_states as a # 4x4 Local coordinate system.
#   E.g. a 3x3 system would look like this:
#
#     ============================
#     | (-1,1)  | (0,1)  | (1,1) |
#     ============================
#     | (-1,0)  | (0,0)  | (1,0) |
#     ============================
#     | (-1,-1) | (0,-1) | (1,-1)|
#     ============================
#
# Each cell in this matrix is a Point2f instance and the zero location (0,0) corresponds to :origin.
# If a specific coordinate is encoded in configuration stores in :position_states, then use that cell.
#
# Each shape has a color assigned.
class Tetris::Shape

  include GameFieldTypeConstants

  # Position in game grid (coordinates) that defines the zero (origin) of this shape's locale coordinate system.
  # NB: update when performing a move operation (translation).
  attr_accessor :origin

  # Current (rotational) configuration of this shape. An Array of Point2f instances and an element of :local_points.
  # NB: update when performing a rotation.
  attr_accessor :local_points

  # Color of shape conforming to Tk's color model.
  attr_reader :color

  # Map that contains the Grid this shape is interacting with.
  attr_accessor :grid_map

  # @param map [Map] game map
  # @param color [Color] color identifier known by Tk
  def initialize(map, color)
    @origin = Point2f.new(5, 0)

    @position_states = position_states

    @rotation_modus = 0
    @local_points = @position_states[@rotation_modus]

    @grid_map = map
    @color = color
    @mutex = Mutex.new
    @play_sound_effect = false

    map_positions.each do |p|
      @grid_map.set_field_color_at(p.x, p.y, color)
    end

  end

  # Is it possible to rotate this shape?
  #
  # @hint: Every shape, except the Square Shape can be rotated.
  # @return [Boolean] true if shape can be rotated otherwise false.
  def rotatable?
    true
  end

  # A collection of orientations of a given shape.
  # Each sub.array represents an shape orientation state
  # Each shape has 4 states, i.e. 4 sub-arrays.
  # @return [Array] of Arrays that contain Point2f elements
  def position_states
    raise "not implemented yet."
  end

  # Retrieve next rotational configuration (clock-wise 90 degree) of this shape.
  def next_rotated_shape
    next_rotation_position.map do |point|
      Point2f.new(point.x + origin.x + 1, point.y + origin.y + 1)
    end
  end

  # @param shift [Point2f] translation vector.
  def next_translated_shape(shift)
    translated_origin = next_moved_origin(shift)
    local_points.map do |point|
      Point2f.new(point.x + translated_origin.x, point.y + translated_origin.y)
    end
  end

  # Rotate this shape by 90 degree clock-wise.
  # Assigns next rotational configuration of this shape by
  # updating :local_points using the configurations in :position_states.
  # In case the current rotation attempt causes a collision, then do nothing.
  # when successfully performing a rotation, play the corresponding sound effect.
  # @return [Boolean] should sound effect be played? It is :true if yes otherwise :false.
  def rotate
    @play_sound_effect = false
    unless Tetris::CollisionChecker.new(self, :rotate).blocked?
      @mutex.synchronize do

        @play_sound_effect = true

        map_positions.each do |p|
          @grid_map.clear_field_at(p.x, p.y)
          @grid_map.set_field_type_at(p.x, p.y, FREE)
        end

        @rotation_modus = (@rotation_modus + 1) % 4
        @local_points = @position_states[@rotation_modus]

        map_positions.each do |p|
          @grid_map.set_field_color_at(p.x, p.y, @color)
          @grid_map.set_field_type_at(p.x, p.y, MOVING)
        end
      end
    end
    @play_sound_effect
  end

  # Move this shape either to the left, right, or downwards by a given step.
  # In case the current movement attempt causes a collision, then do nothing.
  #
  # @param move_by [Point2f] (optional) relative movement given as a Point2f.
  #        encodes how many step in x-and y direction we have to move from this
  #        shape's origin.
  # @param movement_type [Symbol] type of movement.
  #        is either (default) :move - move shape downwards movement
  #        or :move_sidewards - move shape to the left or right
  def move_shape(move_by=Point2f.new(0,0), movement_type = :move)
    collision_state = Tetris::CollisionChecker.new(self, movement_type, move_by)

    if !collision_state.blocked?
      @mutex.synchronize do

        map_positions.each do |p|
          @grid_map.clear_field_at(p.x, p.y)
          @grid_map.set_field_type_at(p.x, p.y, FREE)
        end

        update_position_by(move_by)

        map_positions.each do |p|
          @grid_map.set_field_color_at(p.x, p.y, @color)
          @grid_map.set_field_type_at(p.x, p.y, MOVING)
        end
      end
    elsif collision_state.state == :grounded
      @grid_map.spawn_new_shape
    end
  end

  def to_s
    (@local_points.map &:to_s).join(" ")
  end

  # Map the locale shape gestalt coordinates to game grid coordinates.
  #
  # @return [Array] of Point2f shape gestalt coordinates in game grid coordinates.
  def points_in_grid_coords
    @local_points.map do |point|
      Point2f.new(point.x + @origin.x + 1, point.y + @origin.y + 1)
    end
  end

  # place current configuration of this shape in game grid
  # end game in case a game over movement happened
  # otherwise ask grid map to check whether the
  # current placement resulted in a combo.
  def mark_fields_placed
    points_in_grid_coords.each do |p|
      target_cell = @grid_map.field_at(p.x, p.y)
      target_cell.type = PLACED
    end

    return @grid_map.initiate_game_over if was_game_over_movement?

    @grid_map.check_for_combo
  end

  # check whether last move operation resulted in a placement filling a whole row
  # i.e. resulted in a combo
  def apply_combo_check
    @grid_map.check_for_combo
  end

  protected

  # Retrieve next rotational configuration (clock-wise 90 degree) of this shape.
  #
  # @return [Array] of Point2f instances defining the rotated gestalt of this shape.
  def next_rotation_position
    @position_states[(@rotation_modus+1)%4]
  end

  # Get a copy translated origin.
  # In grid coordinates.
  #
  # @param shift [Point2f] translation vector.
  # @return [Point2f] translated copy of origin.
  def next_moved_origin(shift)
    Point2f.new(1,1).add(@origin).add(shift)
  end

  # Check for Game over movement if we want to place a block onto a
  # cell is placed an top inner row.
  #
  # @return [Boolean] :true if we got killed by current placement
  #         otherwise :false
  def was_game_over_movement?
    points_in_grid_coords.each do |p|
      target_cell = @grid_map.field_at(p.x, p.y)
      if p.y == 1 && target_cell.type == PLACED
        return true
      end
    end
    false
  end

  # position of this shape in map coordinate system
  def map_positions
    shifted_position(@origin)
  end

  # updates local postions of this shape
  def update_position_by(shift)
    @origin = @origin.add(shift)
  end

  # local shape gestalt coordinates translated by :shift_by
  #
  # @param base origin we want to shift.
  # @param shift_by [Point2f] shift base by this point
  # @return [Array] of translated local shape gestalt coordinates
  def shifted_position(base, shift_by=Point2f.new(0,0))
    @local_points.map do |cell|
      Point2f.new(base.x + cell.x + shift_by.x + 1, base.y + cell.y + shift_by.x + 1)
    end
  end

end
