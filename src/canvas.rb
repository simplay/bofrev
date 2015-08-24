require 'render_helpers'
require 'color'

require 'java'
java_import 'javax.swing.JPanel'

class Canvas < JPanel

  include RenderHelpers

  attr_writer :game

  # @param g [Java::Graphics] graphic component used by java awt
  def initialize
    super
    setBackground(Color.white.to_awt_color)
  end

  def paintComponent(g)
    drawing_methods(g)
  end

  protected

  def drawing_methods(g)
    raise "not implemented yet"
  end

end
