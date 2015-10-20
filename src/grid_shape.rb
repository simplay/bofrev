require 'point2f'
require_relative 'collision_checker'
require 'game_field_type_constants'

class GridShape
  include GameFieldTypeConstants
  include Enumerable


  attr_reader :color

  # Initialize a new GridShape. Assign its origin.
  #
  # @param grid [Grid] the grid this GridShape is interacting with.
  # @param origin [Point2f] position this shape's barycenter is placed on its grid.
  # @param color [Color] 24bit rgb color.
  def initialize(grid, origin, color)
    @origin = origin
    @grid = grid
    @color = color
    @rotation_modus = 0
    @checker = GridCollisionChecker.new(grid, self)
    mark_on_grid_as(MOVING)
  end

  # A list of all rotational position configurations.
  # Each configuration depicts this Shape's gestalt.
  #
  # @info: Each shape is supposed to implement all of its
  #   four rotational configuations.
  # @return [Array] of Arrays that contain Point2f elements
  def rotational_positions
    raise "not implemented yet."
  end

  def positions
    rotational_positions[@rotation_modus]
  end

  def each(&block)
    positions.each do |position|
      if block_given?
        block.call position
      else
        yield position
      end
    end
  end

  # @param shift_value [Point2f] the value we want to shift the origin.
  def try_translate_origin_by(shift_value)
    if @checker.shape_can_be_shifted_by?(shift_value)
      clear_old_state
      translate_origin_by(shift_value)
    end
  end

  # Translates the origin of this shape by a given Point2f.
  #
  # @hint: This method is used to move a shape in x,y direction.
  #   shift is performed in the Shape coordinate system.
  # @param shift_value [Point2f] the value we want to shift the origin.
  def translate_origin_by(shift_value)
    @origin.add(shift_value)
  end

  # Place this Shape's position on its Grid and mark
  # the type of the affected GameField instances as PLACED.
  def place_on_grid
    mark_on_grid_as(PLACED)
  end

  def try_rotate
    rotate if @checker.shape_can_be_rotated?
  end

  def rotate
    (@rotation_modus+1)%4
  end

  # Mark this Shape's postions on its Grid with a given type.
  #
  # @hint: Grid locations that correspond to this Shape's position locations
  #   will be colored by this shape's color and the field type is set according
  #   to a given type.
  # @param type [Symbol] a GameFieldTypeConstants value.
  def mark_on_grid_as(type)
    positions_in_grid_space.each do |position|
      x = position.x
      y = position.y
      @grid.set_field_color_at(x,y,@color)
      @grid.set_field_type_at(x,y,type)
    end
  end

  # Transforms the local Shape positions to this Shape's Grid
  # coordinate System.
  #
  # @hint: Note that all initial Shape positions are defined
  #   in a local Shape coordinate System.
  #   Shape positions encode the actual gestalt of a Shape.
  #   Since every Grid has a boarder, the index 0 and N+1 are
  #   Border grid points. Border GameField instances are not
  #   are used a delimiter. This is why we apply the +1 in the
  #   coordinate transformation.
  # @return [Array] of Point2f positions transformed to
  #   the Grid coordinate system.
  def positions_in_grid_space
    map do |position|
      x = @origin.x + position.x + 1
      y = @origin.y + position.y + 1
      Point2f.new(x,y)
    end
  end

end
