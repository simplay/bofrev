require 'game_settings'
require 'observer'
require 'event'
require 'main_frame'

require 'java'
java_import 'java.awt.event.KeyListener'
java_import 'java.awt.event.MouseListener'
java_import 'java.awt.event.MouseMotionListener'
java_import 'java.awt.event.ActionListener'

class View < Observer

  # @param game [Game] business model containing data to draw.
  def initialize(game)
    game.subscribe(self)
    @game = game
    @is_suspended = game.paused?
    @main_frame = MainFrame.new(game)
    attach_listeners
    clicked_onto_start
  end

  # @overridden from [Observer]
  def handle_event
    @main_frame.update_canvas unless @game.finished?
  end

  # @overridden from [Observer]
  def handle_event_with(message)
    java.lang.System.exit(0) if message.type == :killed
  end

  protected

  def attach_listeners
    @main_frame.add_key_listener KeyListener.impl { |name, event|
      # key_debugger("KeyListener", name, event)
      value_pressed_key = key_pressed_for(event.getKeyChar)
      event_identifier = "#{name}_#{value_pressed_key}"
      handle_pressed_key(event_identifier) if allowed_event?(event_identifier)
    }

    @main_frame.add_mouse_motion_listener MouseMotionListener.impl { |name, event|
      # key_debugger("MouseMotionListener", name, event)
      offsets = @main_frame.offsets
      x = event.getX-offsets[0]/2
      y = event.getY-offsets[1]/2
      event_identifier = "#{name}_#{event.get_button}"
      handle_mouse_events(x, y, event_identifier) if allowed_event?(event_identifier, :mouse)
    }

    @main_frame.add_mouse_listener MouseListener.impl { |name, event|
      # key_debugger("MouseListener", name, event)
      offsets = @main_frame.offsets
      x = event.getX-offsets[0]/2
      y = event.getY-offsets[1]/2
      event_identifier = "#{name}_#{event.get_button}"
      handle_mouse_events(x, y, event_identifier) if allowed_event?(event_identifier, :mouse)
    }

    @main_frame.start_button.addActionListener ActionListener.impl { |name, event|
      puts "start button clicked"
      @main_frame.start_button.setEnabled(false)
      @main_frame.pause_button.setEnabled(true)
      @main_frame.requestFocusInWindow
    }

    @main_frame.pause_button.addActionListener ActionListener.impl { |name, event|
      if @is_suspended
        @main_frame.pause_button.set_text("pause")
        @game.resume
      else
        @main_frame.pause_button.set_text("resume")
        @game.pause
      end
      @is_suspended = !@is_suspended
      @main_frame.requestFocusInWindow
    }

  end

  # is this view not suspended?
  #
  # @return [Boolean] true if game is running and otherwise false.
  def running?
    !@is_suspended
  end

  # Derive what key has been pressed by parsing the received key coding.
  #
  # @param key_value [Integer] integer key value.
  # @return [String] key string identifier.
  def key_pressed_for(key_value)
    (key_value > 255)? key_value.to_s : key_value.chr
  end

  def allowed_event?(identifier, type=:keyboard)
    GameSettings.allowed_controls[type].include?(identifier) && running?
  end

  def key_debugger(listener_type, name, event)
    puts "#{listener_type} DEBUGGER DETECTED:"
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
    @game.perform_loop_step(message)
  end

  def clicked_onto_start
    @game.run
  end

end
