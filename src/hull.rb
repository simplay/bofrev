require 'point2f'
require_relative 'drawables/quadratic_hull_shape'

# Conservative detection of collisions between a #shape and other obstacles.
class Hull

  # @param shape [Shape] enclosing shape.
  def initialize(shape, is_debugging=false)
    @shape = shape
    @gestalt = QuadraticHullShape.new(shape, is_debugging)

    image = shape.image
    width = image.width
    height = image.height
    @p = Point2f.new(width/2.0, height/2.0)
  end

  def top_left
    barycenter.copy.sub(@p)
  end

  def bottom_right
    barycenter.copy.add(@p)
  end

  def barycenter
    @shape.center
  end

  def gestalt
    @gestalt
  end

end
