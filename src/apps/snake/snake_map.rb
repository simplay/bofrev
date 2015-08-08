require 'map'
require 'game_settings'
require 'color'
require_relative 'snake'

class SnakeMap < Map

  def initialize(game)
    super(game)
    @prev_iter_grid = Grid.new(GameSettings.width_pixels, GameSettings.height_pixels)
    @mutex = Mutex.new

    @movement_direction = Point2f.new(1.0, 0.0)
    @snake_pos = Point2f.new(1.0, 1.0)
    @snake = Snake.new(@snake_pos)

    @total_omnomnoms = 0

    place_omnomnom
    place_snake(@movement_direction)
  end

  # defines how user input should be handled to update the game state.
  def process_event(message)

    if message.type == 'd'
      @movement_direction = Point2f.new(1,0)
    elsif message.type == 'a'
      @movement_direction = Point2f.new(-1,0)
    elsif message.type == 's'
      @movement_direction = Point2f.new(0,1)
    elsif message.type == 'w'
      @movement_direction = Point2f.new(0,-1)
    end

  end

  def process_ticker
    update_snake_pos(@movement_direction)
    place_omnomnom if (@game.ticker_thread.total_elapsed_ticks%10 == 0 && @total_omnomnoms < 2)
  end

  private

  def place_snake(movement_direction)
    @mutex.synchronize do
      @snake.positions.each do |snake_pos|
        field = @grid.field_at(snake_pos.x, snake_pos.y)
        if field.color == Color.green
          # increase snake length
          move_dir = movement_direction.copy.scale_by(-1.0)
          @snake.append_segment
          @snake.move_by(move_dir)
          @total_omnomnoms -= 1
        end
      end
    end
  end

  def place_omnomnom
    @total_omnomnoms += 1
    rand_x = rand(1..GameSettings.width_pixels)
    rand_y = rand(1..GameSettings.height_pixels)
    field = @grid.field_at(rand_x, rand_y)
    field.color = Color.green
  end

  def unmark_snake
    @snake.positions.each do |snake_pos|
      field = @grid.field_at(snake_pos.x, snake_pos.y)
      field.color = Color.white
    end
  end

  def update_snake_pos(movement_dir)
    unmark_snake
    @snake.move_by(movement_dir)
    place_snake(movement_dir)
    @snake.positions.each do |snake_pos|
      field = @grid.field_at(snake_pos.x, snake_pos.y)
      field.color = Color.red
    end
  end

end
