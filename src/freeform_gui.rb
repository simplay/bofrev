require_relative 'gui'
require 'tk'

# TODO: Move to src/views/
#
# Game grid graphical user interface.
# follow mvc pattern: gui knows game
class FreeformGui < Gui

  # @param game [Game]
  def initialize(game)
    super(game)
  end

  def prepended_initialization_steps
    @background = TkPhotoImage.new(:file => "backgrounds/city.gif")
    @ticks = 0
  end

  # invoked drawing methods performed in the defined ascending order.
  def apply_draw_methods
    draw_background
    draw_grid_cells
  end

  def post_build_gui_steps
  end

  protected

  def draw_background
    offset = @ticks % 200
    background_img = TkcImage.new(@canvas, offset, 200, 'image' => @background)
    @ticks = @ticks + 2
    background_img
  end

  def draw_grid_cells
    @game.map.shapes.each do |shape|
      shape.draw_onto(@canvas)
    end

  end

end
