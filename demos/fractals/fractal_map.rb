require 'map'
require 'game_settings'
require_relative 'fractal'

class FractalMap < Map

  def initialize(game)
    super(game)
    @allow_updates = false
    @mutex = Mutex.new
    @layer_manager.append_to([Fractal.new], :foreground)
  end

  # defines how user input should be handled to update the game state.
  def process_event(message)
  end

  # defines how thicker should update this map.
  def process_ticker
  end

end
