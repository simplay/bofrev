require 'map'
require 'game_settings'
require 'color'

class PingPongMap < Map

  def initialize(game)
    super(game)
    @prev_iter_grid = Grid.new(GameSettings.width_pixels, GameSettings.height_pixels)
    @allow_updates = false
    @mutex = Mutex.new

    @current_position = [19,20,21]

    init_pos
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
    if shft < 1
      next_idx = @current_position.min + shft
      wipe_out = @current_position.pop
      wipe_out_at(wipe_out)
      @current_position.reverse!
      @current_position << next_idx
      @current_position.reverse!
    else
      next_idx = @current_position.max + shft
      wipe_out = @current_position.reverse!.pop
      wipe_out_at(wipe_out)
      @current_position.reverse!
      @current_position << next_idx
    end
    init_pos
  end

  def init_pos
    @current_position.each do |pos|
      @grid.set_field_at(pos,20,GameField.new(Color.blue))
    end
  end

  def wipe_out_at(idx)
    @grid.set_field_at(idx,20,GameField.new(Color.white))
  end

end
