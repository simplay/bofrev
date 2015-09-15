require 'render_helpers'
require 'color'

require 'java'
java_import 'javax.swing.JPanel'

# A Canvas is a java JPanel and is used to draw Drawable instances onto it.
# This class acts as a abstract representation of a canvas and has no implement
# how and what should be drawn onto it. This has to be implemented by a descendent class.
# Therefore, a class thas inherits from Canvas has only to implement Canvas#drawing_methods
# in order to define a drawing behaviour.
# In case a Canvas needs to know about its parent Game, there is the possiblilty to store
# a Game instance that can be accesses internally via @game.
# By default, a canvas' background is drawn in white.
class Canvas < JPanel

  include RenderHelpers

  attr_writer :game

  # Initialize JFrame acting as a canvas and draw its background in white.
  def initialize
    super
    setBackground(Color.white.to_awt_color)
  end

  # Paints a graphic instance using some defined Canvas#drawing_methods onto a canvas.
  #
  # @param g [Java::Graphics] graphic component used by java awt
  def paintComponent(g)
    super(g)
    drawing_methods(g)
  end

  protected

  # Determines how content is supposed to be drawn onto a canvas graphics object.
  #
  # @hint: Has to be drawn by a descendent class in order to define a drawin behaviour.
  # @param g [Java::Graphics] graphic component used by java awt
  def drawing_methods(g)
    raise "not implemented yet"
  end

end
