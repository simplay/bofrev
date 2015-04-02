require_relative '../map'
require_relative '../game_settings'

class GameOfLifeMap < Map

  def initialize(game)
    super(game)
    @prev_iter_grid = Grid.new(WIDTH_PIXELS, HEIGHT_PIXELS)
    @allow_updates = false
  end

  # defines how user input should be handled to update the game state.
  def process_event(message)
    if message.type == :left_click
      p = transform_coordinates(message.content)

      field = field_at(p.x,p.y)

      color = (field.color == 'white')? 'green' : 'white'

      set_field_color_at(p.x, p.y, color)
      set_field_value_at(p.x, p.y, 1.0 - field.value)

    elsif message.type == :left_drag
      p = transform_coordinates(message.content)
      set_field_color_at(p.x, p.y, 'green')
      set_field_value_at(p.x, p.y, 1.0)
    elsif message.type == 'a'
      @allow_updates = !@allow_updates
    end
  end

  # defines how thicker should update this map.
  def process_ticker
    update_grid
  end

  private

  def update_grid

    if @allow_updates

      @prev_iter_grid.inner_height_iter.each do |row_idx|
        @prev_iter_grid.inner_width_iter.each do |idx|


          current_cell = @grid.field_at(idx, row_idx)
          summed_value = current_cell.sum_8_neighbor_values

          perform_update = false
          if current_cell.color == 'green'

            if summed_value < 2.0
              color = 'white'
              value = 0.0
              perform_update = true

            elsif summed_value > 3.0
              color = 'white'
              value = 0.0
              perform_update = true

            else
              color = 'green'
              value = 1.0
              perform_update = true
            end

          else

            if summed_value == 3.0
              color = 'green'
              value = 1.0
              perform_update = true
            end

          end

          if perform_update == true
            @prev_iter_grid.set_field_value_at(idx, row_idx, value)
            @prev_iter_grid.set_field_color_at(idx, row_idx, color)
          end

        end
      end

      @grid.overwrite_us_with(@prev_iter_grid)

    end


    puts "updates on: #{@allow_updates}"
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