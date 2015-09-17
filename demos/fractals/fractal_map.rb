require 'map'
require 'game_settings'

class FractalMap < Map

  def initialize(game)
    super(game)
    @allow_updates = false
    @mutex = Mutex.new
  end

  # defines how user input should be handled to update the game state.
  def process_event(message)
  end

  # defines how thicker should update this map.
  def process_ticker
  end

end
