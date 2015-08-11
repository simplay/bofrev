require 'map'
require 'game_settings'
require 'player'

class DemoSpritesMap < Map

  JUMP_STEP_HEIGHT = 5
  def initialize(game)
    super(game)
    @prev_iter_grid = Grid.new(GameSettings.width_pixels, GameSettings.height_pixels)
    @allow_updates = true
    @mutex = Mutex.new
    @player = Player.new
    self.append_shape(@player.gestalt)
  end

  # defines how user input should be handled to update the game state.
  def process_event(message)
    case message.type
    when W_KEY
      @player.jump unless @player.jumping?
    when D_RELEASED
      @player.stop_walking
    when A_RELEASED
      @player.stop_walking
    when D_PRESSED
      @player.walk(:right)
    when A_PRESSED
      @player.walk(:left)
    end
    puts @player.to_s
  end

  # defines how thicker should update this map.
  def process_ticker
    @player.update_position
  end

end
