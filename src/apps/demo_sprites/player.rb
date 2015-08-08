require_relative '../../drawables/shape'
require_relative '../../point2f'

class Player

  JUMP_STEP_HEIGHT = 5
  HEIGHT_STEP = 2

  def initialize
    @gestalt = Shape.new
    @current_height_lvl = 0
    @is_jumping = false
    @is_walking = false
    @walking = 0
  end

  def update_position
    jump if jumping?
  end

  def jump
    @is_jumping = update_height_lvl
  end

  def jumping?
    @is_jumping
  end

  def walk(direction)

  end

  protected

  def update_height_lvl
    if @current_height_lvl <= JUMP_STEP_HEIGHT
      @current_height_lvl = @current_height_lvl + 1
      @gestalt.translate_by(Point2f.new(@walking, JUMP_STEP_HEIGHT))
      true
    else
      @current_height_lvl = @current_height_lvl - 1
      @gestalt.translate_by(Point2f.new(@walking, JUMP_STEP_HEIGHT))
      @current_height_lvl != 0
    end
  end

  # @param shift [Point2f] relative movement along x,y axis.
  def move_by(shift, scale=3, y=0)
    @gestalt.translate_by(Point2f.new(scale*shft, y))
  end

end
