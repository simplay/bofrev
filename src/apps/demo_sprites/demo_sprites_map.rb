require_relative '../../map'
require_relative '../../game_settings'
require_relative '../../shape'

class DemoSpritesMap < Map

  def initialize(game)
    super(game)
    @prev_iter_grid = Grid.new(GameSettings.width_pixels, GameSettings.height_pixels)
    @allow_updates = true
    @mutex = Mutex.new

    @current_position = [19,20,21]
    @player_shape = Shape.new
    self.append_shape(@player_shape)

  end

  # defines how user input should be handled to update the game state.
  def process_event(message)
    if message.type == 'd'
      move_by(1)
    elsif message.type == 'a'
      move_by(-1)
    end
  end

  # defines how thicker should update this map.
  def process_ticker
    # move ball
  end

  def move_by(shft)
    @player_shape.shift_by(Point2f.new(3*shft, 0))
  end


end
