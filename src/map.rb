require_relative 'game_field'
require_relative 'settings'
require_relative 'shape'
require_relative 'point2f'
require_relative 'sound_effect'
require_relative 'shapes/square'
require_relative 'shape_spawner'

class Map

  include Settings

  def initialize(game)
    @sound_effect = SoundEffect.new
    @game = game
    @grid = Grid.new(WIDTH_PIXELS, HEIGHT_PIXELS)
    spawn_new_shape
  end

  def spawn_new_shape
    @shape = ShapeSpawner.new(self).next
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
    @sound_effect.play(:kick)
    @grid.inner_height_iter.each do |idy|
      row_deletable = @grid.inner_row_at(idy).all? &:placed?
      if row_deletable
        clear(idy)
        down_by_one(idy-1)
        @game.update_score_by(10)
      end
    end
  end

  # sink all inner cells from row 1 (not zero) till :till_row_idx
  def down_by_one(from_row_idx)
    (1..from_row_idx).to_a.reverse.each do |row_idx|
      @grid.inner_width_iter.each do |idx|
        @grid.field_at(idx, row_idx+1).copy_state_from(@grid.field_at(idx, row_idx))
      end
    end
  end

  # clears the whole inner row at index :idx
  def clear(idx)
    @sound_effect.play(:explosion)
    @grid.inner_row_at(idx).each &:wipe_out
  end

  # handle user input and update game state accordingly.
  def process_event(message)
    if message == 'd'
      @shape.move_shape(Point2f.new(1,0), :move_sidewards)
    elsif message == 'a'
      @shape.move_shape(Point2f.new(-1,0), :move_sidewards)
    elsif message == 's'
      @shape.move_shape(Point2f.new(0, 1))
    elsif message == 'w'
      was_rotated = @shape.rotate
      @sound_effect.play(:jump) if was_rotated
    end
  end

  def top_inner_grid_row
    @grid.inner_row_at(1)
  end

  def initiate_game_over
    @game.initiate_game_over
  end

end