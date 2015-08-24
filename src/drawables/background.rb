require_relative 'drawable'
require 'point2f'
require 'sprites'
require 'java'

class Background < Drawable
  def initialize
    super(Point2f.new, true)
    @sprites = Sprites.new("backgrounds", true)
    @current_img = @sprites.images.first
  end

  # Draw this shape onto a given canvas.
  def draw_onto(canvas)
    canvas.drawImage(image, position.x, position.y, nil)
  end

  def update_animation_state
  end

  def image
    @current_img
  end

end
