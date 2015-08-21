require 'game_settings'
require 'observer'
require 'event'
require 'main_frame'

require 'java'
java_import 'java.awt.event.KeyListener'
java_import 'java.awt.event.MouseListener'

class View < Observer

  def initialize(game)
    game.subscribe(self)
    @game = game
    @main_frame = MainFrame.new(game)
    attach_listeners
    clicked_onto_start
  end

  def attach_listeners
    @main_frame.add_key_listener KeyListener.impl { |name, event|
      # key_debugger(name, event)
      value_pressed_key = event.getKeyChar.chr
      event_identifier = "#{name}_#{value_pressed_key}"
      handle_pressed_key(event_identifier) if allowed_event?(event_identifier)
    }

    @main_frame.addMouseListener do |event|
      x = event.getX
      y = event.getY
      button = event.getButton
      type = event.paramString.split(",").first
      identifier = "#{type.downcase}_#{button}"
      handle_mouse_events(x, y, identifier)
      puts "mouse event: #{type}, b=#{button}, (#{x},#{y})"
    end
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

  def handle_mouse_events(x,y, type)
    puts "handling event: #{type} at (#{x}, #{y})"
    message = Event.new(type, Point2f.new(x,y))
    #@game.perform_loop_step(message)
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
