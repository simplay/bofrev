require_relative 'settings'

require_relative 'shapes/square'
require_relative 'shapes/short_line_piece'
require_relative 'shapes/l_piece'
require_relative 'shapes/reverse_l_piece'
require_relative 'shapes/reverse_squiggly'
require_relative 'shapes/squiggly'
require_relative 'shapes/t_block'


class ShapeSpawner
  include Settings

  def initialize(map)
    @shape_types = [
        Square,
        ShortLinePiece,
        LPiece,
        ReverseLPiece,
        ReverseSquiggly,
        Squiggly,
        TBlock
    ]
    @map = map
  end

  # @return
  def next
    idx = Random.rand(0..@shape_types.length-1) % @shape_types.length
    @shape_types[idx].new(@map, random_color)
  end

end