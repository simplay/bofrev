require 'canvas'
require 'point2f'

require 'java'
class MyCanvas < Canvas

  attr_writer :game

  def drawing_methods(g)
      draw_grid_cells(g)
      draw_empty_grid(g, cell_size)
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
  def draw_horizontal_lines_with(g, step_size)
    # rounded down numbers of lines.
    (y_pixels-1).times do |idx|
      draw_line(g, Point2f.new(0, (idx)*step_size), Point2f.new(width_pixels*step_size, (idx)*step_size))
    end
  end

  # Draws vertical lines with a given distance on a canvas.
  #
  # @param canvas [TkCanvas] canvas a line should be drawn onto.
  # @param step_size [Integer] pixel distance between two lines.
  def draw_vertical_lines_with(g, step_size)
    # rounded down numbers of lines.
    (x_pixels-1).times do |idx|
      draw_line(g, Point2f.new((idx)*step_size, 0), Point2f.new((idx)*step_size, (height_pixels)*step_size))
    end
  end

  # Draw a black coloured line from point :p_s to :p_e.
  #
  # @param canvas [TkCanvas] canvas a line should be drawn onto.
  # @param p_s [Integer] starting point.
  # @param p_e [Integer] end point.
  # @param options [Hash] containing options of TkcLine#new
  #        line color, filled, width, etc.
  def draw_line(g, p_s, p_e, options = {})
    g.setColor(Color.black.to_awt_color)
    g.drawLine(p_s.x, p_s.y, p_e.x, p_e.y)
  end

  # note that x-coord corresponds to the column idx
  # note that y-coord corresponds to the row idx
  def draw_grid_cells(g)
    x_iter.each do |column_id|
      y_iter.each do |row_idx|
        field = @game.map.field_at(column_id, row_idx)
        if field.drawable?
          x0 = (column_id-1)*cell_size
          y0 = (row_idx-2)*cell_size
          x1 = (column_id-0)*cell_size
          y1 = (row_idx-1)*cell_size
          draw_rectangle_at(g, x0, y0, x1, y1, field.color)
        end
      end
    end
  end

  # Draw a colored rectangle with having a certain border width onto @canvas.
  #
  # @hint Its top left position is given by a point (x0,y0) and
  # its size by the span between the first and a 2nd point (x1, y1).
  #
  # @param x0 [Integer] or [Float] upper left corner x-component
  # @param y0 [Integer] or [Float] upper left corner y-component
  # @param x1 [Integer] or [Float] lower right corner x-component
  # @param y1 [Integer] or [Float] lower right corner y-component
  # @param color [String] color identifier.
  # @param border_width [Integer] border pixel thickness.
  def draw_rectangle_at(g, x0, y0, x1, y1, color)
    g.setColor(color.to_awt_color)
    g.fillRect(x0, y1, x1-x0, y1-y0)
  end

end
