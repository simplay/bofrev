require_relative 'shapes/square'
require_relative 'shapes/line_piece'
require_relative 'settings'

class ShapeSpawner
  include Settings

  def initialize(map)
    @shape_types = [Square, LinePiece]
    @map = map
  end

  # @return
  def next
    idx = Random.rand(0..@shape_types.length-1) % @shape_types.length
    @shape_types[idx].new(@map, random_color)
  end

end