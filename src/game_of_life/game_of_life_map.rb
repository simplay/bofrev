require_relative '../map'
require_relative '../game_settings'

class GameOfLifeMap < Map

  def initialize(game)
    super(game)
    update_grid
  end

  # defines how user input should be handled to update the game state.
  def process_event(message)
    if message.type == :left_click
      p = transform_coordinates(message.content)

      field = field_at(p.x,p.y)

      color = (field.color == 'white')? 'green' : 'white'
      set_field_color_at(p.x, p.y, color)
    elsif message.type == :left_drag
      p = transform_coordinates(message.content)
      set_field_color_at(p.x, p.y, 'green')
    end
    #raise "not implemented yet"
  end

  # defines how thicker should update this map.
  def process_ticker
    #raise "not implemented yet"
  end

  private

  def update_grid
    @prev_iter_grid = @grid
  end

  # TODO: think about porting this method to Map
  #
  # from canvas coordinates (clicked at position) to grid coordinates
  # (determine which grid cell has been clicked)
  # @param point [Point2f] canvas coordinates
  # @return [Point2f] (inner) grid coordinates
  def transform_coordinates(point)

    x_frac = (CELL_SIZE.to_f/WIDTH_PIXELS)
    y_frac = (CELL_SIZE.to_f/HEIGHT_PIXELS)

    x_grid = (point.x / (x_frac*WIDTH_PIXELS.to_f)).to_i
    y_grid = (point.y / (y_frac*HEIGHT_PIXELS.to_f)).to_i

    # truncated: TODO report this
    x_grid = WIDTH_PIXELS if x_grid > WIDTH_PIXELS
    y_grid = HEIGHT_PIXELS if y_grid > HEIGHT_PIXELS


    # since there is a border around the grid we have to shift the zero
    grid_p = Point2f.new(x_grid, y_grid).add(Point2f.new(1,1))

    puts "(#{grid_p})"
    grid_p
  end


end