require 'my_canvas'
require 'control_constants'

require 'java'
java_import 'javax.swing.JFrame'

class MainFrame < JFrame

  include ControlConstants

  def initialize(game)
    super("GAME")
    @game = game
    init_gui
  end

  def init_gui
    @canvas = MyCanvas.new
    @canvas.game = @game
    getContentPane.add(@canvas)
    setDefaultCloseOperation(JFrame::EXIT_ON_CLOSE)
    setSize(700, 700)
    setLocationRelativeTo(nil)
    setVisible(true)
  end

  def update_canvas
    @canvas.repaint
  end

end
