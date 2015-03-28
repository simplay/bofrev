require_relative 'game_field'
require_relative 'settings'
require_relative 'point2f'
require_relative 'sound_effect'

class Map

  include Settings

  def initialize(game)
    @sound_effect = SoundEffect.new
    @game = game
    @grid = Grid.new(WIDTH_PIXELS, HEIGHT_PIXELS)
  end

  def set_field_at(x, y, color)
    @grid.set_field_color_at(x, y, color)
  end

  def field_at(x,y)
    @grid.field_at(x,y)
  end

  # clears the whole inner row at index :idx
  def clear(idx)
    @sound_effect.play(:explosion)
    @grid.inner_row_at(idx).each &:wipe_out
  end

  # handle user input and update game state accordingly.
  def process_event(message)
    raise "not implemented yet"
  end

  def top_inner_grid_row
    @grid.inner_row_at(1)
  end

  def initiate_game_over
    @game.initiate_game_over
  end

end