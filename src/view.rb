require 'observer'
require 'event'
require 'main_frame'

require 'java'
java_import 'java.awt.event.KeyListener'

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
      case name
      when :keyPressed
        value_pressed_key = event.getKeyChar.chr
        handle_pressed_key(value_pressed_key)
      when :keyReleased
      end
    }
  end

  # @param type [String] key identifier that was pressed.
  def handle_pressed_key(type)
    puts "#{type} was pressed."
    @game.perform_loop_step(Event.new(type)) unless @game.finished?
  end

  def handle_event
    @main_frame.update_canvas unless @game.finished?
  end

  def clicked_onto_start
    @game.run
  end

end
