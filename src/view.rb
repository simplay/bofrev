require 'game_settings'
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
      # key_debugger(name, event)
      value_pressed_key = event.getKeyChar.chr
      event_identifier = "#{name}_#{value_pressed_key}"
      handle_pressed_key(event_identifier) if allowed_event?(event_identifier)
    }
  end

  def allowed_event?(identifier)
      GameSettings.allowed_controls.include?(identifier)
  end

  def key_debugger(name, event)
    puts "KEY DEBUGGER DETECTED:"
    puts "n: #{name}"
    puts "e: #{event}"
  end

  # @param type [String] key identifier that was pressed.
  def handle_pressed_key(type)
    puts "handling event: #{type}"
    @game.perform_loop_step(Event.new(type)) unless @game.finished?
  end

  def handle_event
    @main_frame.update_canvas unless @game.finished?
  end

  def handle_event_with(message)
    java.lang.System.exit(0) if message.type == :killed
  end

  def clicked_onto_start
    @game.run
  end

end
