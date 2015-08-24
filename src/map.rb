require 'grid'
require 'game_field'
require 'point2f'
require 'sound_effect'
require 'game_settings'
require 'control_constants'
require_relative 'drawables/shape_manager'
require 'layer_manager'

class Map

  include ControlConstants

  def initialize(game)
    @sound_effect = SoundEffect.new(GameSettings.sound_effect_list)
    @game = game
    @grid = Grid.new(GameSettings.width_pixels, GameSettings.height_pixels)
    @shape_manager = ShapeManager.new
    @layer_manager = LayerManager.new
  end

  def shapes
    @shape_manager.shapes
  end

  def layer_manager
    @layer_manager
  end

  # Appends a a Shape instance to @shape_manager.
  # @param shape [Shape]
  def append_shape(shape)
    @shape_manager.append(shape)
  end

  # Removes a a Shape instance from @shape_manager.
  # @param shape [Shape]
  def remove_shape(shape)
    @shape_manager.remove(shape)
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

  def handle_ticker_notification
    layer_manager.update_layer(:center)
    process_ticker
  end

  def handle_user_input_notification_for(message)
    # preconditions
    process_event(message)
    # postconditions
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

  # from canvas coordinates (clicked at position) to grid coordinates
  # (determine which grid cell has been clicked)
  # @param point [Point2f] canvas coordinates
  # @return [Point2f] (inner) grid coordinates
  def transform_coordinates(point)
    puts "initial: #{point}"

    x_frac = (GameSettings.cell_size.to_f/GameSettings.width_pixels)
    y_frac = (GameSettings.cell_size.to_f/GameSettings.height_pixels)

    x_grid = (point.x / (x_frac*GameSettings.width_pixels.to_f)).to_i
    y_grid = (point.y / (y_frac*GameSettings.height_pixels.to_f)).to_i

    # truncated: TODO report this
    x_grid = GameSettings.width_pixels if x_grid > GameSettings.width_pixels
    y_grid = GameSettings.height_pixels if y_grid > GameSettings.height_pixels


    # since there is a border around the grid we have to shift the zero
    grid_p = Point2f.new(x_grid, y_grid).add(Point2f.new(1,1))

    puts "transformed: #{grid_p}"
    grid_p
  end


  protected

  # defines how user input should be handled to update the game state.
  # TODO make scope private
  def process_event(message)
    raise "not implemented yet"
  end

  # defines how thicker should update this map.
  # TODO make scope private
  def process_ticker
    raise "not implemented yet"
  end

end
