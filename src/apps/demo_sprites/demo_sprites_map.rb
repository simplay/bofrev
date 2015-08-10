require 'map'
require 'game_settings'
require_relative 'player'

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
    if message.type == 'w'
      @player.jump unless @player.jumping?
    elsif message.type == 'KeyRelease-d'
      @player.stop_walking
    elsif message.type == 'KeyRelease-a'
      @player.stop_walking
    elsif message.type == 'KeyPress-d'
      @player.walk(:right)
    elsif message.type == 'KeyPress-a'
      @player.walk(:left)
    end
    puts @player.to_s
  end

  # defines how thicker should update this map.
  def process_ticker
    @player.update_position
  end

end
