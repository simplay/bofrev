require_relative '../map'
require_relative '../game_settings'
require_relative 'snake'
require 'pry'

class SnakeMap < Map

  def initialize(game)
    super(game)
    @prev_iter_grid = Grid.new(GameSettings.width_pixels, GameSettings.height_pixels)
    @mutex = Mutex.new

    @movement_direction = Point2f.new(1.0, 0.0)
    @snake_pos = Point2f.new(1.0, 1.0)
    @snake = Snake.new(@snake_pos, @movement_direction)

    @total_omnomnoms = 0

    place_omnomnom
    place_snake
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
    puts @snake.to_s
    update_snake_pos
    place_omnomnom if (@game.ticker_thread.total_elapsed_ticks%10 == 0 && @total_omnomnoms < 2)
  end

  private

  def place_snake
    @mutex.synchronize do
      @snake.positions.each do |snake_pos|
        field = @grid.field_at(snake_pos.x, snake_pos.y)
        if field.color == 'green'
          # increase snake length
          move_dir = @movement_direction.copy.scale_by(-1.0)
          copied_head = @snake.tail.copy
          @snake.append_position(copied_head.add(move_dir))
          @snake.append_movement(@movement_direction)

          @total_omnomnoms -= 1
        end
      end
      @snake.cleanup_positions
    end
  end

  def place_omnomnom
    @total_omnomnoms += 1
    rand_x = rand(1..GameSettings.width_pixels) 
    rand_y = rand(1..GameSettings.height_pixels)
    field = @grid.field_at(rand_x, rand_y)
    field.color = 'green'
  end

  def unmark_snake
    @snake.positions.each do |snake_pos|
      field = @grid.field_at(snake_pos.x, snake_pos.y)
      field.color = 'white'
    end
  end

  def update_snake_pos
    unmark_snake
    @snake.update_movement(@movement_direction)
    @snake.move
    place_snake
    @snake.positions.each do |snake_pos|
      field = @grid.field_at(snake_pos.x, snake_pos.y)
      field.color = 'red'
    end
  end

end
