require 'point2f'
require 'observer'
require 'game_settings'
require 'event'
require 'control_constants'
require 'java_color_wrapper'
require 'java'
java_import 'javax.swing.JPanel'
java_import 'javax.swing.JFrame'

class Canvas < JPanel

  # @param g [Java::Graphics] graphic component used by java awt
  def paintComponent(g)
    drawing_methods(g)
  end

  protected

  def drawing_methods(g)
    raise "not implemented yet"
  end

end
class Wrapper
end
class MyCanvas < Canvas
    def drawing_methods(g)
        draw_color_rectangles(g)
    end

    def draw_color_rectangles(g)
        5.times do |i|
          5.times do |j|
            r_value = rand(255)
            g_value = rand(255)
            b_value = rand(255)
            color = Java::JavaAwt::Color.new(r_value, g_value, b_value)

            g.setColor(color)
            g.fillRect(10+120*i, 15+90*j, 90, 60)
          end
        end
    end
end

class MainFrame < JFrame
  include ControlConstants
  def initialize(game)
    super("foobar")
    @game = game
    init_gui
  end

  def init_gui
    @canvas = MyCanvas.new
    getContentPane.add(@canvas)
    setDefaultCloseOperation(JFrame::EXIT_ON_CLOSE)
    setSize(700, 700)
    setLocationRelativeTo(nil)
    setVisible(true)
  end

  def update_canvas
    @canvas.repaint
    # @game.perform_loop_step(Event.new(W_KEY))
  end

end

class View < Observer

  def initialize(game)
    game.subscribe(self)
    @game = game
    @main_frame = MainFrame.new(game)
    clicked_onto_start
  end

  def handle_event
    @main_frame.update_canvas
  end

  def clicked_onto_start
    @game.run
  end

end
