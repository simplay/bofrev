require_relative '../../color'

require_relative 'shapes/square'
require_relative 'shapes/l_piece'
require_relative 'shapes/reverse_l_piece'
require_relative 'shapes/reverse_squiggly'
require_relative 'shapes/squiggly'
require_relative 'shapes/t_block'
require_relative 'shapes/line_piece'
require_relative 'tetris'

class Tetris::ShapeSpawner

  def initialize(map)
    @shape_types = [
        Tetris::Square,
        Tetris::LPiece,
        Tetris::ReverseLPiece,
        Tetris::ReverseSquiggly,
        Tetris::Squiggly,
        Tetris::TBlock,
        Tetris::LinePiece
    ]
    @map = map
  end

  # @return
  def next
    idx = Random.rand(0..@shape_types.length-1) % @shape_types.length
    random_color = Color.next_random
    @shape_types[idx].new(@map, random_color)
  end

end
