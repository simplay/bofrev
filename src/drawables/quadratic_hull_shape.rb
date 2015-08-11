require_relative 'drawable'
require 'color'
require 'point2f'
require 'tk'

class QuadraticHullShape < Drawable
  def initialize(enclosing_shape, drawable)
    super(enclosing_shape.position, drawable)
    image = enclosing_shape.image
    @enclosing_shape = enclosing_shape
    width = image.width
    height = image.height
    @p = Point2f.new(width/2.0, height/2.0)
  end

  def draw_onto(canvas)
    barycenter = @enclosing_shape.center
    upper_left_pos = barycenter.copy.sub(@p)
    lower_right_pos = barycenter.copy.add(@p)
    x0 = upper_left_pos.x
    y0 = upper_left_pos.y
    x1 = lower_right_pos.x
    y1 = lower_right_pos.y
    TkcRectangle.new(canvas, x0, y0, x1, y1,
                     'width' => 2)
  end

end
