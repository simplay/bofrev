require_relative 'point2f'
require_relative 'observer'
require 'tk'
require 'tkextlib/tile'

# Game grid graphical user interface.
# follow mvc pattern: gui knows game
class Gui < Observer

  MAX_WIDTH = 240
  MAX_HEIGHT = 600
  CELL_SIZE = 20

  A_KEY = 'a'
  W_KEY = 'w'
  D_KEY = 'd'
  S_KEY = 's'

  def initialize(game)
    game.subscribe(self)
    @game = game
    build_gui_components
    attach_gui_listeners # forms controller in MVC
    Tk.mainloop
  end

  # when we got notified by game (has new data for gui)
  # then we are supposed to redraw the gui.
  def handle_event
    draw_game_state
    puts "gui redrawn"
  end

  def draw_game_state
    draw_empty_grid(@canvas, CELL_SIZE)
    # draw filled cells
  end

  def perform_gui_close_steps
    detach_all_listeners
    @canvas.destroy
    # TODO show score and then ask user for playing another game.
  end

  private

  def build_gui_components
    @root = TkRoot.new do
      title "GAME"
      minsize(MAX_WIDTH+10,MAX_HEIGHT+10)
    end

    @canvas = TkCanvas.new(@root)
    @canvas.grid :sticky => 'nwes', :column => 0, :row => 0

    TkGrid.columnconfigure(@root, 0, :weight => 1)
    TkGrid.rowconfigure(@root, 0, :weight => 1)
    draw_empty_grid(@canvas, CELL_SIZE)

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
    @game.perform_loop_step(type)
  end

  def attach_gui_listeners
    # TODO set focus on root
    @root.bind(A_KEY, proc { handle_pressed_key(A_KEY) })
    @root.bind(W_KEY, proc { handle_pressed_key(W_KEY) })
    @root.bind(D_KEY, proc { handle_pressed_key(D_KEY) })
    @root.bind(S_KEY, proc { handle_pressed_key(S_KEY) })
  end

  # Unbind all root event listeners
  def detach_all_listeners
    @root.bind(A_KEY, proc {})
    @root.bind(W_KEY, proc {})
    @root.bind(D_KEY, proc {})
    @root.bind(S_KEY, proc {})
  end

  # Draws a regular grid onto a given canvas with a width of :cell_width.
  # @param canvas [TkCanvas] canvas the grid is drawn onto.
  def draw_empty_grid(canvas, cell_width)
    draw_horizontal_lines_with(canvas, cell_width)
    draw_vertical_lines_with(canvas, cell_width)
  end

  # Draws horizontal lines with a given distance on a canvas.
  #
  # @param canvas [TkCanvas] canvas a line should be drawn onto.
  # @param step_size [Integer] pixel distance between two lines.
  def draw_horizontal_lines_with(canvas, step_size)
    # rounded down numbers of lines.
    number_of_lines = MAX_HEIGHT / step_size
    number_of_lines.times do |idx|
      draw_line(canvas, Point2f.new(0, idx*step_size), Point2f.new(MAX_WIDTH, idx*step_size))
    end
  end

  # Draws vertical lines with a given distance on a canvas.
  #
  # @param canvas [TkCanvas] canvas a line should be drawn onto.
  # @param step_size [Integer] pixel distance between two lines.
  def draw_vertical_lines_with(canvas, step_size)
    # rounded down numbers of lines.
    number_of_lines = MAX_WIDTH / step_size
    number_of_lines.times do |idx|
      draw_line(canvas, Point2f.new(idx*step_size, 0), Point2f.new(idx*step_size, MAX_HEIGHT))
    end
  end

  # Draw a black coloured line from point :p_s to :p_e.
  #
  # @param canvas [TkCanvas] canvas a line should be drawn onto.
  # @param p_s [Integer] starting point.
  # @param p_e [Integer] end point.
  # @param options [Hash] containing options of TkcLine#new
  #        line color, filled, width, etc.
  def draw_line(canvas, p_s, p_e, options = {})
    TkcLine.new(canvas, p_s.x, p_s.y, p_e.x, p_e.y, options)
  end

end