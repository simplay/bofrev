require 'my_canvas'
require 'control_constants'
require 'game_settings'
require 'java'
java_import 'javax.swing.JFrame'
java_import 'java.awt.BorderLayout'
java_import 'java.awt.Dimension'

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
    #setSize(GameSettings.max_width, GameSettings.max_height)
    offset_x = 1
    offset_y = 3
    setMinimumSize(Dimension.new(GameSettings.max_width+offset_x, GameSettings.max_height+offset_y))
    setLocationRelativeTo(nil)
    setVisible(true)
    setResizable(false)
    requestFocusInWindow
  end

  def update_canvas
    @canvas.repaint
  end

end
