require 'tk'
require 'tkextlib/tile'

class FractalView
  MUTE = true
  LAST_X_PIXEL = 300.0
  LAST_Y_PIXEL = 300.0
  MAX_ITER = 100
  def initialize
    build_gui_components
    x_pixels = LAST_X_PIXEL.to_i+1
    y_pixels = LAST_Y_PIXEL.to_i+1
    x_pixels.times do |x|
      y_pixels.times do |y|
        draw_fractal_pixel_at(x, y, 2.5)
      end
    end
    Tk.mainloop
  end
  
  def build_gui_components
    @root = TkRoot.new do
      title "Fractal Renderer"
      delta = 4
      minsize(LAST_X_PIXEL.to_i + delta, LAST_Y_PIXEL.to_i + delta)
      maxsize(LAST_X_PIXEL.to_i + delta, LAST_Y_PIXEL.to_i + delta)
    end

    @canvas = TkCanvas.new(@root)
    @canvas.grid :sticky => 'nwes', :column => 0, :row => 0
    TkGrid.columnconfigure( @root, 0, :weight => 1 )
    TkGrid.rowconfigure( @root, 0, :weight => 1 )
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
  def draw_fractal_pixel_at(p_x, p_y, zoom_lvl)
    # transform pixel coordinates to normalized coordinates
    sq_zoom_lvl = Math.sqrt(zoom_lvl)
    zoomed_x_min = -2.5 / sq_zoom_lvl
    zoomed_x_max = 1.0 / sq_zoom_lvl
    zoomed_y_min = -1.0 / sq_zoom_lvl
    zoomed_y_max = 1.0 / sq_zoom_lvl

    x0 = transform_pixel_to_range(0.0, LAST_X_PIXEL, zoomed_x_min, zoomed_x_max, p_x)
    y0 = transform_pixel_to_range(0.0, LAST_Y_PIXEL, zoomed_y_min, zoomed_y_max, p_y)
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
      color = (iter) % max_iter
      color = to_12bit_color(color)
      TkcRectangle.new(@canvas, p_x, p_y, p_x, p_y,
                       'width' => 0, :fill  => color)
    end

  end

  # @param color [Integer] computed color value
  # @return [String] TKTinter color 12 bit format. 
  def to_12bit_color(color)
      prefix = ((0..((8-color.to_s(2).length))).map do "0" end).join
      color = "#{prefix}#{color.to_s(2)}"
      color =  (color.split("").map do |char| (char == '0')? '0' : 'f' end).join 
      color = "##{color}"
      color = color[0..9] if color.length > 10
      puts color unless MUTE
      color
  end
end
