require_relative 'point2f'
require_relative 'observer'
require_relative 'settings'
require_relative 'game_settings'
require_relative 'event'
require_relative 'control_constants'

require 'tk'
require 'tkextlib/tile'

# Game grid graphical user interface.
# follow mvc pattern: gui knows game
class FreeformGui

  include GameSettings
  include ControlConstants

  # @param game [Game]
  def initialize(game)
    game.subscribe(self)
    @game = game
    @may_render = true
    build_gui_components
    attach_gui_listeners # forms controller in MVC
    clicked_onto_start
    Tk.mainloop
  end

  # when we got notified by game (has new data for gui)
  # then we are supposed to redraw the gui.
  def handle_event
    puts self.class.to_s
    draw_game_state
  end

  def draw_game_state
    return unless @may_render
    @may_render = false
    draw_grid_cells
    @may_render = true
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
    @may_render = true
    @game.perform_loop_step(Event.new(type, nil))
  end

  def attach_gui_listeners
    # TODO set focus on root
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

  # note that x-coord corresponds to the column idx
  # note that y-coord corresponds to the row idx
  def draw_grid_cells
    @canvas.delete('all')
    @game.map.shapes.each do |shape|
      if shape.image?
        image = shape.image
        x = shape.position.x + image.height/2
        y = shape.position.y + image.width/2
        TkcImage.new(@canvas, x, y, 'image' => image)

      end
    end

  end

end
