module Settings
  MAX_WIDTH = 240
  MAX_HEIGHT = 600

  CELL_SIZE = 20
  WIDTH_PIXELS = 10

  HEIGHT_PIXELS = 20
  COLORS = %w(green blue red yellow orange)

  def random_color
    idx = Random.rand(COLORS.length)
    COLORS[idx]
  end

  def x_pixels
    WIDTH_PIXELS + 2
  end

  def y_pixels
    HEIGHT_PIXELS + 2
  end

  def inner_x_pixels
    (MAX_WIDTH / CELL_SIZE)
  end

  def inner_y_pixels
    (MAX_HEIGHT / CELL_SIZE)
  end

  def x_iter
    (1..WIDTH_PIXELS)
  end

  def y_iter
    (1..HEIGHT_PIXELS)
  end

end