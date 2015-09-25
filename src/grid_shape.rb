require 'point2f'
require_relative 'collision_checker'
require 'game_field_type_constants'

class GridShape
  include GameFieldTypeConstants
  include Enumerable

  # Initialize a new GridShape. Assign its origin.
  # @param grid [Grid] the grid this GridShape is interacting with.
  def initialize(grid)
    @origin = Point2f.new
    @grid = grid
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

  def can_be_shifted_by?(shift_value)
  end

  def try_translate_origin_by(shift_value)
    if can_be_shifted_by?
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
    positions_in_grid_space.each do |position|
      x = position.x
      y = position.y
      @grid.set_field_color_at(x,y,@color)
      @grid.set_field_type_at(x,y,PLACED)
    end
  end

  # Transforms the local Shape positions to this Shape's Grid
  # coordinate System.
  #
  # @hint: Note that all initial Shape positions are defined
  #   in a local Shape coordinate System.
  #   Shape positions encode the actual gestalt of a Shape.
  # @return [Array] of Point2f positions transformed to
  #   the Grid coordinate system.
  def positions_in_grid_space
    positions.map do |position|
      x = @origin.x + position.x + 1
      y = @origin.y + position.y + 1
      Point2f.new(x,y)
    end
  end

end
