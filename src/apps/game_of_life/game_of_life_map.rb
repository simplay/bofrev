require 'map'
require 'game_settings'
require 'color'

class GameOfLifeMap < Map

  def initialize(game)
    super(game, :placed)
    @allow_updates = false
    @mutex = Mutex.new
  end

  # defines how user input should be handled to update the game state.
  def process_event(message)
    case message.type
    when LEFT_MOUSE_BUTTON_PRESSED
      p = to_grid_coord(message.content)
      field = field_at(p.x,p.y)
      color = (field.color == Color.white)? Color.green : Color.white
      set_field_color_at(p.x, p.y, color)
      set_field_value_at(p.x, p.y, 1.0 - field.value)
    when LEFT_MOUSE_BUTTON_DRAGGED
      p = transform_coordinates(message.content)
      set_field_color_at(p.x, p.y, Color.green)
      set_field_value_at(p.x, p.y, 1.0)
    when A_KEY
      @allow_updates = !@allow_updates
    when W_KEY
      @game.ticker_thread.inc_speed
    when S_KEY
      @game.ticker_thread.dec_speed
    end
  end

  # defines how thicker should update this map.
  def process_ticker
    @mutex.synchronize do
      update_grid
    end
  end

  private

  def update_grid
    if @allow_updates

      @prev_iter_grid.inner_height_iter.each do |row_idx|
        @prev_iter_grid.inner_width_iter.each do |idx|

          current_cell = @grid.field_at(idx, row_idx)
          summed_value = current_cell.sum_8_neighbor_values

          perform_update = false
          if current_cell.color == Color.green

            if summed_value < 2.0
              color = Color.white
              value = 0.0
              perform_update = true

            elsif summed_value > 3.0
              color = Color.white
              value = 0.0
              perform_update = true

            else
              color = Color.green
              value = 1.0
              perform_update = true
            end

          else

            if summed_value == 3.0
              color = Color.green
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

end
