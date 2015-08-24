require_relative 'drawable'
require 'point2f'
require 'sprites'

require 'java' if (RUBY_PLATFORM == "java")

class Background < Drawable
  def initialize(is_animated=true)
    super(Point2f.new(-10,-10), true)
    @is_animated = is_animated
    @sprites = Sprites.new("backgrounds", true)
    @current_img = @sprites.images.first
    @counter = 0
  end

  # Draw this shape onto a given canvas.
  def draw_onto(canvas)
    canvas.drawImage(image, position.x, position.y, nil)
  end

  def update_animation_state
    return unless @is_animated
    if @counter < 100
      shift = Point2f.new(-1,0)
    elsif @counter < 200
      shift = Point2f.new(1,0)
    else
      shift = Point2f.new(0,0)
      @counter = 0
    end
    translate_by(shift)
    @counter = @counter + 1
  end

  protected

  def image
    @current_img
  end

end
