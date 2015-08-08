require 'point2f'
require 'sprites'
require_relative 'drawable'
require 'tk'

# Shape represents a drawable objects used by a freefrom_gui renderer.
# TODO: Make use of instancing
class Shape < Drawable

  # @param position [Point2f] barycenter and world position of this Shape.
  # @param update_rate [Integer] update every 20th tick.
  # @param sprite_folder_name [String] filepath of sprite images used for
  # animating this shape.
  def initialize(position = Point2f.new, update_rate=20, sprite_folder_name = 'dummy/')
    super(position, true)

    @sprites = Sprites.new(sprite_folder_name)
    @current_img = @sprites.images.first
    @switch_counter = 0
    @swith_rate = update_rate
  end

  # Draw this shape onto a given canvas.
  #
  # @param canvas [TkCanvas]
  def draw_onto(canvas)
    if image?
      x = position.x + image.height/2
      y = position.y + image.width/2
      TkcImage.new(canvas, x, y, 'image' => image)
    end
  end

  # Does this shape have some sprite images associated with.
  #
  # @return [Boolean] true if this Shape has sprite images otherwise false.
  def image?
    @sprites.count > 0
  end

  # returns image that is used for texturing this shape.
  # @return [TkPhotoImage] image used to create a TkcImage.
  def image
    default_animation
  end

  protected

  # Returns idle animation image.
  def default_animation
    @switch_counter = (@switch_counter + 1) % @swith_rate
    @current_img = @sprites.next_image if (@switch_counter == @swith_rate / 2)
    @current_img
  end

  # Returns current animation image.
  def movement_animation
    raise "not implemented yet"
  end

end
