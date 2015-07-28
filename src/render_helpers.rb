# This module offers a gui/view some neat helper methods to simplify the indexing used by all the canvas drawing methods (for grid based rendering approaches).
module RenderHelpers

  # Get the number of all width pixels, including the border pixels,
  # contained in a Map#grid.
  #
  # @hint note that every grid has a 1 pixel wide border.
  # @return [Integer] of all width pixel indices.
  def x_pixels
    width_pixels + 2
  end

  # Get the number of all height pixels, including the border pixels,
  # contained in a Map#grid.
  #
  # @hint note that every grid has a 1 pixel wide border.
  # @return [Integer] of all height pixel indices.
  def y_pixels
    height_pixels + 2
  end

  # Get the number of inner width pixels contained in a Map#grid.
  #
  # @hint note that every grid has a 1 pixel wide border.
  # @return [Integer] of all inner width pixel indices.
  def inner_x_pixels
    (max_width / cell_size)
  end

  # Get the number of inner height pixels contained in a Map#grid.
  #
  # @hint note that every grid has a 1 pixel wide border.
  # @return [Integer] of all inner height pixel indices.
  def inner_y_pixels
    (max_height / cell_size)
  end

  # Get all width (x-indices) pixel indices including the border pixels.
  # Is used to access Field instances of a Grid by canvas-Gui draw methods.
  #
  # @hint note that every grid has a 1 pixel wide border.
  # @return [Range] of all width pixel indices.
  def x_iter
    (1..width_pixels)
  end

  # Get all height (y-indices) pixel indices including the border pixels.
  # Is used to access Field instances of a Grid by canvas-Gui draw methods.
  #
  # @hint note that every grid has a 1 pixel wide border.
  # @return [Range] of all height pixel indices.
  def y_iter
    (1..height_pixels)
  end
end
