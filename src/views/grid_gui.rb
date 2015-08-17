require 'point2f'
require 'gui'
if (RUBY_PLATFORM != "java")
  require 'tk'
  require 'tkextlib/tile'
end

# TODO: RENAME to GridGui
#
# Grid based drawing of game objects.
class GridGui < Gui

  def initialize(game)
    super(game)
  end

  def prepended_initialization_steps
  end

  def apply_draw_methods
    draw_empty_grid(@canvas, cell_size)
    draw_grid_cells
  end

  def post_build_gui_steps
    draw_empty_grid(@canvas, cell_size)
  end

  protected

  # Draws a regular grid onto a given canvas with a width of :cell_width.
  # @param canvas [TkCanvas] canvas the grid is drawn onto.
  def draw_empty_grid(canvas, cell_width)
    draw_horizontal_lines_with(canvas, cell_width)
    draw_vertical_lines_with(canvas, cell_width)
  end

  # Draws horizontal lines with a given distance on a canvas.
  #
  # @param canvas [TkCanvas] canvas a line should be drawn onto.
  # @param step_size [Integer] pixel distance between two lines.
  def draw_horizontal_lines_with(canvas, step_size)
    # rounded down numbers of lines.
    (y_pixels-1).times do |idx|
      draw_line(canvas, Point2f.new(0, (idx)*step_size), Point2f.new(width_pixels*step_size, (idx)*step_size))
    end
  end

  # Draws vertical lines with a given distance on a canvas.
  #
  # @param canvas [TkCanvas] canvas a line should be drawn onto.
  # @param step_size [Integer] pixel distance between two lines.
  def draw_vertical_lines_with(canvas, step_size)
    # rounded down numbers of lines.
    (x_pixels-1).times do |idx|
      draw_line(canvas, Point2f.new((idx)*step_size, 0), Point2f.new((idx)*step_size, height_pixels*step_size))
    end
  end

  # Draw a black coloured line from point :p_s to :p_e.
  #
  # @param canvas [TkCanvas] canvas a line should be drawn onto.
  # @param p_s [Integer] starting point.
  # @param p_e [Integer] end point.
  # @param options [Hash] containing options of TkcLine#new
  #        line color, filled, width, etc.
  def draw_line(canvas, p_s, p_e, options = {})
    TkcLine.new(canvas, p_s.x, p_s.y, p_e.x, p_e.y, options)
  end

  # note that x-coord corresponds to the column idx
  # note that y-coord corresponds to the row idx
  def draw_grid_cells
    x_iter.each do |column_id|
      y_iter.each do |row_idx|
        field = @game.map.field_at(column_id, row_idx)
        if field.drawable?
          x0 = (column_id - 1)*cell_size
          y0 = (row_idx - 1)*cell_size

          x1 = column_id*cell_size
          y1 = row_idx*cell_size

          draw_rectangle_at(x0, y0, x1, y1, field.color_value, 1)
        end
      end
    end
  end

end
