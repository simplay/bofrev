require_relative 'drawables/quadratic_hull_shape'

# Conservative detection of collisions between a #shape and other obstacles.
class Hull

  # @param shape [Shape] enclosing shape.
  def initialize(shape, is_debugging=false)
    @shape = shape
    @gestalt = QuadraticHullShape.new(shape, is_debugging)
  end

  def gestalt
    @gestalt
  end

end
