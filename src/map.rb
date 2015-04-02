require_relative 'game_field'
require_relative 'settings'
require_relative 'point2f'
require_relative 'sound_effect'
require_relative 'game_settings'

class Map

  include Settings

  def initialize(game)
    @sound_effect = SoundEffect.new(GameSettings.sound_effect_list)
    @game = game
    @grid = Grid.new(WIDTH_PIXELS, HEIGHT_PIXELS)
  end

  def set_field_color_at(x, y, color)
    @grid.set_field_color_at(x, y, color)
  end

  def set_field_value_at(x, y, value)
    @grid.set_field_value_at(x, y, value)
  end

  def clear_field_at(x, y)
    @grid.flush_field_at(x, y)
  end

  def field_at(x,y)
    @grid.field_at(x,y)
  end

  # clears the whole inner row at index :idx
  def clear(idx)
    @sound_effect.play(:explosion)
    @grid.inner_row_at(idx).each &:wipe_out
  end

  # defines how user input should be handled to update the game state.
  def process_event(message)
    raise "not implemented yet"
  end

  # defines how thicker should update this map.
  def process_ticker
    raise "not implemented yet"
  end

  def initiate_game_over
    @game.initiate_game_over
  end

end