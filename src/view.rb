require 'point2f'
require 'observer'
require 'game_settings'
require 'event'
require 'control_constants'
require 'java'
java_import 'javax.swing.JPanel'
java_import 'javax.swing.JFrame'
java_import 'java.awt.event.KeyListener'

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
            r_value = rand(255).to_java(:int)
            g_value = rand(255).to_java(:int)
            b_value = rand(255).to_java(:int)
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
    super("GAME")
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
  end

end

class View < Observer

  def initialize(game)
    game.subscribe(self)
    @game = game
    @main_frame = MainFrame.new(game)
    attach_key_listener
    clicked_onto_start
  end

  def attach_key_listener
    @main_frame.add_key_listener KeyListener.impl { |name, event|
      #puts "name: #{name} event:#{event}"
      case name
      when :keyPressed
        value_pressed_key = event.getKeyChar.chr
        handle_pressed_key(value_pressed_key)
      when :keyReleased
      end
    }
  end
  # @hint: key meanings
  #   a - move left
  #   d - move right
  #   s - faster down
  #   w - rotate shape clock-wise
  # @param type [String] key identifier that was pressed.
  def handle_pressed_key(type)
    puts "#{type} was pressed."
    @game.perform_loop_step(Event.new(type))
  end

  def handle_event
    @main_frame.update_canvas
  end

  def clicked_onto_start
    @game.run
  end

end
