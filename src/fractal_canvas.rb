require 'canvas'
require 'point2f'
require 'color'
require 'java'
require 'game_settings'
class FractalCanvas < Canvas

  MUTE = true
  BITS_PER_COLOR_CHANNEL = 8
  MAX_ITER = 255

  def drawing_methods(g)
    draw_shapes(g)
  end

  def draw_shapes(g)
    @x_pixels = GameSettings.width_pixels
    @y_pixels = GameSettings.height_pixels
    (@x_pixels+1).times do |x|
      (@y_pixels+1).times do |y|
        draw_fractal_pixel_at(g, x, y, 4.3)
      end
    end
  end

  private

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
    g.fillRect(x0, y0, x1-x0, y1-y0)
  end

  def transform_pixel_to_range(min_a, max_a, min_e, max_e, x)
    s = (max_e - min_e) / (max_a - min_a)
    min_e + s*(x-min_a)
  end

  # Transforms pixel coordianates into zoomed fractal domain coordinates.
  # E.g. Mandelbrot set is defined within the domain [-2.5,1]x[-1,1].
  #
  # @param p_x [Float] location x pixel
  # @param p_y [Float] location y pixeli
  # @param zoom_lvl [Float] scaled view of fractal domain
  def draw_fractal_pixel_at(graphics, p_x, p_y, zoom_lvl)
    # transform pixel coordinates to normalized coordinates
    sq_zoom_lvl = Math.sqrt(zoom_lvl)
    zoomed_x_min = -2.5 / sq_zoom_lvl
    zoomed_x_max = 1.0 / sq_zoom_lvl
    zoomed_y_min = -1.0 / sq_zoom_lvl
    zoomed_y_max = 1.0 / sq_zoom_lvl

    x0 = transform_pixel_to_range(0.0, @x_pixels, zoomed_x_min, zoomed_x_max, p_x)
    y0 = transform_pixel_to_range(0.0, @y_pixels, zoomed_y_min, zoomed_y_max, p_y)

    x = 0.0; y = 0.0;
    max_iter = MAX_ITER
    iter = 0
    max_iter.times do
      # if convergence radius is greater than r^2
      break if (x**2 - y**2 > 4.0)
      x_tmp = x*x - y*y + x0
      y = 2.0*x*y+y0
      x = x_tmp
      iter = iter + 1
    end

    if iter < max_iter
      bits = BITS_PER_COLOR_CHANNEL
      dig = 2**bits
      r = (dig-1) - iter%dig
      g = iter%dig
      b = ((dig-1)*((iter < max_iter)? 1 : 0)+(dig/2))%dig

      depth = (sq_zoom_lvl*iter).to_i % dig

      r = (r+depth)%dig
      g = (g+depth)%dig
      b = (b+depth)%dig
      color = compute_color_string(r,g,b, bits)
      draw_rectangle_at(graphics, p_x, p_y, p_x+1, p_y+1, Color.new(color))
    end

  end

  # Compute a 3*bits TK fromatted color string.
  def compute_color_string(r,g,b, bits)
    r_s = prefix_zeros(bits, r)+r.to_s(2)
    g_s = prefix_zeros(bits, g)+g.to_s(2)
    b_s = prefix_zeros(bits, b)+b.to_s(2)
    color = "#{r_s}#{g_s}#{b_s}"
    color =  (color.split("").map do |char| (char == '0')? '0' : 'f' end).join
    "#"+color
  end

  def prefix_zeros(bits, c)
    add_count = bits-c.to_s(2).length
    range = 0..add_count
    seq = range.to_a[1..range.size-1].map do |a| "0" end
    seq.join
  end

end
