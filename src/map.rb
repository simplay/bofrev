require_relative 'game_field'
require_relative 'settings'
require_relative 'shape'
require_relative 'point2f'

class Map

  include Settings

  def initialize
    @grid = Grid.new(WIDTH_PIXELS, HEIGHT_PIXELS)
    spawn_new_shape
  end

  def spawn_new_shape
    @shape = Shape.new(self, random_color)
  end

  def move_shape_one_down
    @shape.move_shape(Point2f.new(0, 1))
  end

  def set_field_at(x, y, color)
    @grid.set_field_color_at(x, y, color)
  end

  def field_at(x,y)
    @grid.field_at(x,y)
  end

  # iterate row-wise though grid and look for '4'-rows (w/e border).
  # Each such row should be deleted and a players score should be incremented accordingly.
  def check_for_combo
    @grid.inner_height_iter.each do |idy|
      row_deletable = @grid.inner_row_at(idy).all? &:placed?
      if row_deletable
        clear(idy)
        down_by_one(idy-1)
      end
    end

  end

  # down all inner cells from row 1 (not zero) till :till_row_idx
  def down_by_one(from_row_idx)
    (1..from_row_idx).to_a.reverse.each do |row_idx|
      @grid.inner_width_iter.each do |idx|
        @grid.field_at(idx, row_idx+1).copy_state_from(@grid.field_at(idx, row_idx))
      end
    end
  end

  # clears a whole row
  def clear(idx)
    @grid.inner_row_at(idx).each &:wipe_out
  end

  def process_event(message)
    if message == 'd'
      @shape.move_shape(Point2f.new(1,0))
    elsif message == 'a'
      @shape.move_shape(Point2f.new(-1,0))
    elsif message == 's'
      @shape.move_shape(Point2f.new(0, 1))
    elsif message == 'w'
      @shape.rotate
    end
  end

end