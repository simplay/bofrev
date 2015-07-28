require_relative '../../map'
require_relative '../../game_settings'
require_relative '../../shape'

class DemoSpritesMap < Map

  JUMP_STEP_HEIGHT = 5
  def initialize(game)
    super(game)
    @prev_iter_grid = Grid.new(GameSettings.width_pixels, GameSettings.height_pixels)
    @allow_updates = true
    @mutex = Mutex.new

    @jump_count = 0
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
    elsif message.type == 'w'
      jump unless @jump_count > 0
    end
  end

  # defines how thicker should update this map.
  def process_ticker
    if @jump_count > 5
      @player_shape.translate_by(Point2f.new(0, -JUMP_STEP_HEIGHT))
      @jump_count = @jump_count - 1
    elsif @jump_count > 0
      @player_shape.translate_by(Point2f.new(0, JUMP_STEP_HEIGHT))
      @jump_count = @jump_count - 1
    end
  end

  def jump
    @jump_count = 10
  end

  def move_by(shft)
    @player_shape.translate_by(Point2f.new(3*shft, 0))
  end


end
