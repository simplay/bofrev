require_relative '../map'
require_relative '../game_settings'
require 'pry'

class SnakeMap < Map

  def initialize(game)
    super(game)
    @prev_iter_grid = Grid.new(GameSettings.width_pixels, GameSettings.height_pixels)
    @mutex = Mutex.new

    @movement_direction = Point2f.new(1,0)
    @snake_pos = Point2f.new(1,1)

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
    puts @snake_pos
    update_snake_pos
  end

  private

  def place_snake
    field = @grid.field_at(@snake_pos.x, @snake_pos.y)
    field.color = 'red'
  end

  def unmark_snake
    field = @grid.field_at(@snake_pos.x, @snake_pos.y)
    field.color = 'white'
  end

  def update_snake_pos
    unmark_snake
    @snake_pos.add(@movement_direction)
    place_snake
  end

end