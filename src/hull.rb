require 'point2f'
require_relative 'drawables/quadratic_hull_shape'

# Conservative detection of collisions between a #shape and other obstacles.
class Hull
  DX = 30
  DY = 8
  # @param shape [Shape] enclosing shape.
  def initialize(shape, is_debugging=false)
    @shape = shape
    image = shape.image
    width = image.width
    height = image.height
    @p = Point2f.new(width/2.0 - DX, height/2.0 - DY)
    @gestalt = QuadraticHullShape.new(shape, is_debugging, self)
  end

  def center_shift
    @p
  end

  def center
    @shape.center
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
