require 'tk'
require 'tkextlib/tile'

class FractalView
  def initialize
    build_gui_components
    201.times do |x|
      201.times do |y|
        transform(x, y, 1)
      end
    end
    Tk.mainloop
  end
  
  def build_gui_components
    @root = TkRoot.new do
      title "Fractal Renderer"
      minsize(240, 240)
      maxsize(240, 240)
    end

    @canvas = TkCanvas.new(@root)
    @canvas.grid :sticky => 'nwes', :column => 0, :row => 0
  end
  
  def transform_interval(min_a, max_a, min_e, max_e, x)
    s = (max_e - min_e) / (max_a - min_a)
    min_e + s*(x-min_a)
  end
  # Transforms pixel coordianates into zoomed fractal domain coordinates.
  # E.g. Mandelbrot set is defined within the domain [-2.5,1]x[-1,1].
  #
  # @param p_x [Float] location x pixel
  # @param p_y [Float] location y pixeli
  # @param zoom_lvl [Float] scaled view of fractal domain
  def transform(p_x, p_y, zoom_lvl)
    # transform pixel coordinates to normalized coordinates
    pn_x = p_x.to_f / 200
    pn_y = p_y.to_f / 200
    x0 = transform_interval(0.0, 200.0, -2.5, 1.0, p_x)
    y0 = transform_interval(0.0, 200.0, -1.0, 1.0, p_y)
    x = 0.0; y = 0.0;
    max_iter = 2000
    iter = 0
    while x*x + y*y < 4.0 && iter < max_iter do
      x_tmp = x*x - y*y + x0
      y = 2.0*x*y+y0
      x = x_tmp
      iter = iter + 1
    end
    if iter < 2000
      color = (iter*20+250) % 2000
      prefix = ((1..((15-color.to_s(2).length))).map do "0" end).join
      color = "##{prefix}#{color.to_s(2)}"
      TkcRectangle.new(@canvas, p_x, p_y, p_x, p_y,
                       'width' => 0, :fill  => color)
    end
  end
end
