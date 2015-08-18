require 'my_canvas'
require 'control_constants'
require 'game_settings'
require 'java'
java_import 'javax.swing.JFrame'
java_import 'java.awt.BorderLayout'

class MainFrame < JFrame

  include ControlConstants

  def initialize(game)
    super("GAME")
    @game = game
    init_gui
  end

  def init_gui
    setLayout BorderLayout.new
    @canvas = MyCanvas.new
    @canvas.game = @game
    getContentPane.add(@canvas, BorderLayout::CENTER)
    setDefaultCloseOperation(JFrame::EXIT_ON_CLOSE)
    offset = 7
    setSize(GameSettings.max_width+offset, GameSettings.max_height+3)
    setLocationRelativeTo(nil)
    setVisible(true)
    requestFocusInWindow()
  end

  def update_canvas
    @canvas.repaint
  end

end
