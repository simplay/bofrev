require_relative 'drawable'
require 'color'
require 'point2f'
require 'tk'

class QuadraticHullShape < Drawable

  def initialize(enclosing_shape, drawable, hull)
    super(enclosing_shape.position, drawable)
    @hull = hull
  end

  def draw_onto(canvas)
    barycenter = @hull.center
    upper_left_pos = barycenter.copy.sub(@hull.center_shift)
    lower_right_pos = barycenter.copy.add(@hull.center_shift)
    x0 = upper_left_pos.x
    y0 = upper_left_pos.y
    x1 = lower_right_pos.x
    y1 = lower_right_pos.y
    TkcRectangle.new(canvas, x0, y0, x1, y1,
                     'width' => 2)
  end

end
