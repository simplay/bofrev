require_relative 'drawable'
require 'point2f'

if (RUBY_PLATFORM != "java")
  require 'tk'
  require 'color'
else
  require 'java'
end

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
    draw_rectangle_for(canvas, x0, y0, x1, y1)
  end

  def draw_rectangle_for(canvas, x0, y0, x1, y1)

    if (RUBY_PLATFORM != "java")
      TkcRectangle.new(canvas, x0, y0, x1, y1, 'width' => 2)
    else
      canvas.drawRect(x0, y0, x1-x0, y1-y0)
    end
  end

  def update_animation_state

  end

end
