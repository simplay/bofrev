require_relative 'point2f'
require_relative 'shape_factory'
require 'tk'
# Shape represents a drawable objects used by a freefrom_gui renderer.
# TODO: Make use of instancing
class Shape
  attr_reader :type,    # [Symbol]
              :position # [Point2f]

  # [Boolean] should this Shape be rendered?
  attr_accessor :drawable

  # @param type [Symbol] what prefactored shape should be used.
  # @param position
  def initialize(type = :default, position = Point2f.new, drawable=true)
    @type = type
    @points = ShapeFactory.new(type).build
    @position = position
    @drawable = drawable

    @image2 = TkPhotoImage.new(:file => "sprites/ani1.gif")
    @image1 = TkPhotoImage.new(:file => "sprites/ani2.gif")
    @flag = false
  end

  def shift_by(value)
    @position.add(value)
  end

  def image?
    true
  end

  def image
    @flag = !@flag
    (@flag==true)? @image1 : @image2
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
