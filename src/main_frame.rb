require 'control_constants'
require 'game_settings'

require 'java'
java_import 'javax.swing.JFrame'
java_import 'java.awt.BorderLayout'
java_import 'java.awt.Dimension'
java_import 'javax.swing.JPanel'
java_import 'java.awt.FlowLayout'
java_import 'javax.swing.JButton'
java_import 'javax.swing.Box'
java_import 'java.awt.Container'

class MainFrame < JFrame

  include ControlConstants

  def initialize(game)
    super("GAME")
    @game = game
    init_gui
  end

  def update_canvas
    @canvas.repaint
  end

  def pause_button
    @pause
  end

  def start_button
    @start
  end

  protected

  def init_gui
    container = getContentPane
    container.setLayout(BorderLayout.new)
    @canvas = GameSettings.canvas.new
    @canvas.game = @game
    container.add(@canvas, BorderLayout::CENTER)
    setDefaultCloseOperation(JFrame::EXIT_ON_CLOSE)
    setMinimumSize(Dimension.new(GameSettings.canvas_width, GameSettings.canvas_height))
    controls = JPanel.new
    controls.setLayout(FlowLayout.new(FlowLayout::CENTER))
    container.add(controls, BorderLayout::PAGE_END)

    @start = JButton.new("start");
    @pause = JButton.new("pause");
    @start.setEnabled(false)

    controls.add(@start)
    controls.add(@pause)
    controls.add(Box.createRigidArea(Dimension.new(25, 0)));

    setLocationRelativeTo(nil)
    setVisible(true)
    setResizable(false)
    requestFocusInWindow
    pack
  end

end
