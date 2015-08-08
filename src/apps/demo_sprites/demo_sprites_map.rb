require 'map'
require 'game_settings'
require_relative '../../drawables/shape'
require_relative 'player'

class DemoSpritesMap < Map

  JUMP_STEP_HEIGHT = 5
  def initialize(game)
    super(game)
    @prev_iter_grid = Grid.new(GameSettings.width_pixels, GameSettings.height_pixels)
    @allow_updates = true
    @mutex = Mutex.new
    @walking = 0
    @jump_count = 0
    @current_position = [19,20,21]
    @player_shape = Shape.new
    @player = Player.new
    self.append_shape(@player.gestalt)
  end

  # defines how user input should be handled to update the game state.
  def process_event(message)
    if message.type == 'w'
      @player.jump
    elsif message.type == 'a'
      @player.walk(:left)
    elsif message.type == 'd'
      @player.walk(:right)
    end
  end

  # defines how thicker should update this map.
  def process_ticker
    @player.update_position
  end

end
