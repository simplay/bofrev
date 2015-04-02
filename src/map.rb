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

  # Transforms coordinates in canvas coordinate system
  # to coordinates in grid (index) coordinates.
  #
  # @param canvas_coord [Point2f] canvas coordinates
  # @return [Point2f] (inner) grid coordinates
  def to_grid_coord(canvas_coord)
    transform_coordinates(canvas_coord)
  end

  protected

  # from canvas coordinates (clicked at position) to grid coordinates
  # (determine which grid cell has been clicked)
  # @param point [Point2f] canvas coordinates
  # @return [Point2f] (inner) grid coordinates
  def transform_coordinates(point)

    x_frac = (CELL_SIZE.to_f/WIDTH_PIXELS)
    y_frac = (CELL_SIZE.to_f/HEIGHT_PIXELS)

    x_grid = (point.x / (x_frac*WIDTH_PIXELS.to_f)).to_i
    y_grid = (point.y / (y_frac*HEIGHT_PIXELS.to_f)).to_i

    # truncated: TODO report this
    x_grid = WIDTH_PIXELS if x_grid > WIDTH_PIXELS
    y_grid = HEIGHT_PIXELS if y_grid > HEIGHT_PIXELS


    # since there is a border around the grid we have to shift the zero
    grid_p = Point2f.new(x_grid, y_grid).add(Point2f.new(1,1))

    puts "(#{grid_p})"
    grid_p
  end

end