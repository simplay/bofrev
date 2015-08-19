require 'point2f'
require 'sprites'
require_relative 'drawable'
require 'hull'
if (RUBY_PLATFORM != "java")
  require 'tk'
  require 'pry'
else
  require 'java'
end

# Shape represents a drawable objects used by a freefrom_gui renderer.
# TODO: Make use of instancing
class Shape < Drawable

  IS_DEBUG_MODE = true

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
    @hull = Hull.new(self, IS_DEBUG_MODE)
  end

  def hull
    @hull
  end

  # Draw this shape onto a given canvas.
  #
  # @param canvas [TkCanvas]
  def draw_onto(canvas)
    if image?
      x = position.x + image.height/2.0
      y = position.y + image.width/2.0
      create_image_for(canvas, x, y)
    end
  end

  def create_image_for(canvas, x, y)
    if (RUBY_PLATFORM != "java")
      TkcImage.new(canvas, x, y, 'image' => image)
    else
      canvas.drawImage(image, x, y, nil)
    end
  end

  # @return [Point2f] barycenter of this shape's image.
  def center
    x = position.x + image.height/2.0
    y = position.y + image.width/2.0
    Point2f.new(x,y)
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

  def collide_with(other_drawable, at_position)
    tl = hull.top_left
    br = hull.bottom_right

    otl = other_drawable.hull.top_left
    obr = other_drawable.hull.bottom_right

    l1 = tl.distance_to(otl)
    l2 = br.distance_to(obr)

    d1_xy = tl.direction_to(br)
    d2_xy = otl.direction_to(obr)

    d1 = [d1_xy.x, d2_xy.x].map(&:abs).max
    d2 = [d1_xy.y, d2_xy.y].map(&:abs).max

    intersection_happened = ((l1-d1 < 0) || (l2-d1 < 0))
    puts "intersection happened: #{intersection_happened}"
    # perform collision detection by checking if there occured a line intersection.
    intersection_happened
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
