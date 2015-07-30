require_relative 'point2f'
require_relative 'observer'
require_relative 'game_settings'
require_relative 'event'
require_relative 'control_constants'
require_relative 'render_helpers'

require 'tk'
require 'tkextlib/tile'

# Abstract definition of a general bofrev gui.
# A gui has a canvas, offers some trival drawing methods and
# has key and mouse listeners attached to. A gui canvas gets redrawn
# (according to the definition of Gui#apply_draw_methods after
# it received a notification of its provided game instance.
class Gui < Observer

  include ControlConstants
  include RenderHelpers

  # @param game [Game]
  def initialize(game)
    game.subscribe(self)
    @game = game
    @may_draw = true

    prepended_initialization_steps
    build_gui_components
    post_build_gui_steps
    attach_gui_listeners
    clicked_onto_start

    Tk.mainloop
  end

  # Hook method
  # Additional steps that should be applied before the gui components
  # and listeners are build. All logic invoked within this method
  # is run before the Tk.mainloop has been started.
  def prepended_initialization_steps
    raise "not implemented yet"
  end

  # Hook method
  # Run additional logic after the complete gui has been build
  # and all listeners were attached.
  def post_build_gui_steps
    raise "not implemented yet"
  end

  # Hook method
  # Define how and what should be drawn onto the @canvas
  # after each game notification.
  def apply_draw_methods
    raise "not implemented yet"
  end

  # when we got notified by game (has new data for gui)
  # then we are supposed to redraw the gui.
  def handle_event
    draw_game_state
  end

  def draw_game_state
    return unless @may_draw
    @may_draw = false
    @canvas.delete('all')
    apply_draw_methods
    update_score_tile
    @may_draw = true
  end

  def clicked_onto_start
    @game.run
  end

  def update_score_tile
    @score_tile.text = "Score: #{@game.current_player_score} last unlock #{GameSettings.achievement_system.last_unlock}"
  end

  def perform_gui_close_steps
    detach_all_listeners
    @canvas.destroy
    show_final_score
    # TODO ask user for playing another game.
  end

  protected

  def show_final_score
    content = Tk::Tile::Frame.new(@root) {padding "3 3 12 12"}.grid( :sticky => 'swes')
    TkGrid.columnconfigure @root, 0, :weight => 1; TkGrid.rowconfigure @root, 0, :weight => 1
    @score_tile = Tk::Tile::Label.new(content) {text ''}.grid( :column => 3, :row => 1, :sticky => 'w')
    @score_tile.text = "Game OVER! achievements: #{GameSettings.achievement_system.all_unlocks.join(' ')}"
  end

  def build_gui_components
    @root = TkRoot.new do
      title "GAME"
      offset = 10
      minsize(GameSettings.max_width+offset, GameSettings.max_height+offset)
      maxsize(GameSettings.max_width+offset, GameSettings.max_height+offset)
    end

    @canvas = TkCanvas.new(@root)
    @canvas.grid :sticky => 'nwes', :column => 0, :row => 0

    content = Tk::Tile::Frame.new(@root) {padding "3 3 12 12"}.grid( :sticky => 'nwes')
    TkGrid.columnconfigure @root, 0, :weight => 1
    TkGrid.rowconfigure @root, 0, :weight => 1
    @score_tile = Tk::Tile::Label.new(content) {text "00"}.grid( :column => 3, :row => 1, :sticky => 's')

    TkWinfo.children(content).each {|w| TkGrid.configure w, :padx => 5, :pady => 5}
  end

  def handle_mouse_events(x,y, type)
    puts "clicked at (#{x} #{y})"
    message = Event.new(type, Point2f.new(x,y))
    @game.perform_loop_step(message)
  end

  #
  # @hint: key meanings
  #   a - move left
  #   d - move right
  #   s - faster down
  #   w - rotate shape clock-wise
  # @param type [String] key identifier that was pressed.
  def handle_pressed_key(type)
    puts "#{type} was pressed."
    @may_draw = true
    @game.perform_loop_step(Event.new(type, nil))
  end

  def attach_gui_listeners
    # TODO set focus on root
    @root.bind(W_D_KEYS, proc { handle_pressed_key(W_D_KEYS) })
    @root.bind(W_A_KEYS, proc { handle_pressed_key(W_A_KEYS) })
    @root.bind(A_KEY, proc { handle_pressed_key(A_KEY) })
    @root.bind(W_KEY, proc { handle_pressed_key(W_KEY) })
    @root.bind(D_KEY, proc { handle_pressed_key(D_KEY) })
    @root.bind(S_KEY, proc { handle_pressed_key(S_KEY) })

    @canvas.bind(LEFT_MOUSE_BUTTON_PRESSED, proc{|x, y| handle_mouse_events(x, y, :left_click)}, "%x %y")
    @canvas.bind(LEFT_MOUSE_BUTTON_DRAGGED, proc{|x, y| handle_mouse_events(x, y, :left_drag)}, "%x %y")
  end

  # Unbind all root event listeners
  def detach_all_listeners
    @root.bind(A_KEY, proc {})
    @root.bind(W_KEY, proc {})
    @root.bind(D_KEY, proc {})
    @root.bind(S_KEY, proc {})
  end


  # Draw a colored pixel with having a certain border width onto @canvas.
  #
  # @hint Its top left position is given by a point (x,y)
  #
  # @param x [Integer] or [Float] upper left corner x-component
  # @param y [Integer] or [Float] upper left corner y-component
  # @param color [String] color identifier.
  # @param width [Integer] border pixel thickness.
  def draw_pixel_at(x, y, color)
    draw_rectangle_at(x, y, color, 0)
  end

  # Draw a colored square with having a certain border width onto @canvas.
  #
  # @hint Its top left position is given by a point (x,y)
  # and its width by a :width value (by default zero valued).
  #
  # @param x [Integer] or [Float] upper left corner x-component
  # @param y [Integer] or [Float] upper left corner y-component
  # @param color [String] color identifier.
  # @param border_width [Integer] border pixel thickness.
  # @param width [Integer] pixel valued bottom-right span (by default 0).
  def draw_square_at(x, y, color, border_width, width=0)
    draw_rectangle_at(x, y, x+width, y+width, color, border_width)
  end

  # Draw a colored rectangle with having a certain border width onto @canvas.
  #
  # @hint Its top left position is given by a point (x0,y0) and
  # its size by the span between the first and a 2nd point (x1, y1).
  #
  # @param x0 [Integer] or [Float] upper left corner x-component
  # @param y0 [Integer] or [Float] upper left corner y-component
  # @param x1 [Integer] or [Float] lower right corner x-component
  # @param y1 [Integer] or [Float] lower right corner y-component
  # @param color [String] color identifier.
  # @param border_width [Integer] border pixel thickness.
  def draw_rectangle_at(x0, y0, x1, y1, color, border_width)
    TkcRectangle.new(@canvas, x0, y0, x1, y1,
                     'width' => border_width, 'fill'  => color)
  end

end
