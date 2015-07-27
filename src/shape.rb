require_relative 'point2f'
require_relative 'shape_factory'
require_relative 'sprites'

# Shape represents a drawable objects used by a freefrom_gui renderer.
# TODO: Make use of instancing
class Shape
  attr_reader :type,    # [Symbol]
              :position # [Point2f]

  # [Boolean] should this Shape be rendered?
  attr_accessor :drawable

  # @param type [Symbol] what prefactored shape should be used.
  # @param position
  def initialize(type = :default, position = Point2f.new, drawable=true, update_rate=20)
    @type = type
    @points = ShapeFactory.new(type).build
    @position = position
    @drawable = drawable

    # @image2 = TkPhotoImage.new(:file => "sprites/ani1.gif")
    #@image1 = TkPhotoImage.new(:file => "sprites/ani2.gif")
    @sprites = Sprites.new("dummy/")
    @current_img = @sprites.images.first
    @switch_counter = 0
    @swith_rate = update_rate
  end

  def shift_by(value)
    @position.add(value)
  end

  def image?
    true
  end

  def image
    default_animation
  end

  def default_animation
    @switch_counter = (@switch_counter + 1) % @swith_rate
    @current_img = @sprites.next_image if (@switch_counter == @swith_rate / 2)
    @current_img
  end

  def walking_animation
    raise "not implemented yet"
  end

  def color
    'red'
  end

  # @return [Boolean] true if it should be drawn onto the freefrom_gui canvas.
  def drawable?
    @drawable
  end

  # transformed shape points
  def points
    @points.map do |point|
      position.copy.add(point)
    end
  end

end
