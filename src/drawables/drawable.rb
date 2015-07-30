require 'tk'

class Drawable

  # [Point2f] position in 2d world coordinates and
  # this drawable's barycenter.
  attr_reader :position

  # [Boolean] is it possible to draw this shape.
  # Is true if can be drawn, otherwise it is false.
  # E.g. in case this drawable is occluded then drawable is false.
  attr_accessor :drawable

  # @param position [Point2f] barycenter of this Drawable.
  # @param drawable [Boolean] should this shape be drawn?
  def initialize(position, drawable)
    @position = position
    @drawable = drawable
  end

  # Draw this shape onto a given canvas.
  #
  # @param canvas [TkCanvas]
  def draw_onto(canvas)
    raise "not implemented yet"
  end

  # Is this Drawable instance drawable.
  #
  # @return [Boolean] true if it should be drawn onto a Gui's canvas.
  def drawable?
    @drawable
  end

  # Translate this Drawable's (barycenter) position by a given value.
  #
  # @param value [Point2f] movement in x-and-y position.
  def translate_by(value)
    @position.add(value)
  end

end