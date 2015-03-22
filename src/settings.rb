module Settings
  MAX_WIDTH = 240
  MAX_HEIGHT = 600
  CELL_SIZE = 20

  COLORS = %w(green blue red yellow orange)

  def random_color
    idx = Random.rand(COLORS.length)
    COLORS[idx]
  end

  def x_pixels
    MAX_WIDTH / CELL_SIZE
  end

  def y_pixels
    MAX_HEIGHT / CELL_SIZE
  end

end