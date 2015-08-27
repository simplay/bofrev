require 'color'
require 'drawable'
require 'shape_factory'

class PolygonShape < Drawable

  def initialize(type = :default, position = Point2f.new, drawable=true, update_rate=20, sprite_folder_name = 'dummy/')
    super(position, drawable)
    @type = type
    @points = ShapeFactory.new(type).build
  end

  # Draw this shape onto a given canvas.
  #
  # @param canvas [TkCanvas]
  def draw_onto(canvas)
  end

  def color
    Color.red
  end

  # transformed shape points
  def points
    @points.map do |point|
      position.copy.add(point)
    end
  end
end
