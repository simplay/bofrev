require 'canvas'
require 'point2f'

require 'java'
java_import 'java.awt.Graphics2D'
java_import 'java.awt.Image'
java_import 'javax.imageio.ImageIO'

class FractalCanvas < Canvas

  def drawing_methods(g)
    draw_shapes(g)
  end

  def draw_shapes(g)
  end

end
