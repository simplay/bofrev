require 'drawable'
require 'point2f'
require 'render_helpers'
require 'java'

class GridBox < Drawable

  include RenderHelpers

  def initialize
    super(Point2f.new, true)
  end

  def draw_onto(canvas)
    draw_horizontal_lines_with(canvas)
    draw_vertical_lines_with(canvas)
  end

  private

  # Draws horizontal lines with a given distance on a canvas.
  #
  # @param canvas [TkCanvas] canvas a line should be drawn onto.
  def draw_horizontal_lines_with(g)
    # rounded down numbers of lines.
    (y_pixels-1).times do |idx|
      draw_line(g, Point2f.new(0, (idx)*cell_size), Point2f.new(width_pixels*cell_size, (idx)*cell_size))
    end
  end

  # Draws vertical lines with a given distance on a canvas.
  #
  # @param canvas [TkCanvas] canvas a line should be drawn onto.
  def draw_vertical_lines_with(g)
    # rounded down numbers of lines.
    (x_pixels-1).times do |idx|
      draw_line(g, Point2f.new((idx)*cell_size, 0), Point2f.new((idx)*cell_size, (height_pixels)*cell_size))
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
end
