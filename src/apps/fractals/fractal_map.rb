require_relative '../../map'
require_relative '../../game_settings'

class FractalMap < Map

  def initialize(game)
    super(game)
    @prev_iter_grid = Grid.new(GameSettings.width_pixels, GameSettings.height_pixels)
    @allow_updates = false
    @mutex = Mutex.new
  end

  # defines how user input should be handled to update the game state.
  def process_event(message)
  end

  # defines how thicker should update this map.
  def process_ticker
  end

  private

  def update_grid
  end



end
