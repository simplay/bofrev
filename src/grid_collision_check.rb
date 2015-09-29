class GridCollisionCheck

  # @param grid [Grid]
  # @param shape [GridShape]
  def initialize(grid, shape)
    @grid = grid
    @shape = shape
  end

  def shape_can_be_rotated?
  end

  def shape_can_be_shifted_by?(shift_value)
  end

  # Checks whether a given field with a given shift is colliding with another filed?
  #
  # @param field [GameField] field what should be checked for a collision.
  # @pararm shift_value [Point2f] amount GridCell is shifted
  # @return [Symbol] type of hitting field.
  def field_colliding_when_shifted?(field, shift_value)
    copied_field_coords = field.coordinates.copy
    lookup = copied_field_coords.add(shift_value)
    target_field = @grid.field_at(lookup.x, lookup.y)
    target_field.type
  end

end
