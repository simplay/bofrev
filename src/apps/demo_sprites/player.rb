require 'drawables/shape'
require 'point2f'

class Player

  JUMP_STEP_HEIGHT = 8
  HEIGHT_STEP = 2

  def initialize
    @gestalt = Shape.new
    @current_height_lvl = 0
    @is_jumping = false
    @is_walking = false
    @walking = 0
    @top_reached = false
    @mutex = Mutex.new
  end

  def gestalt
    @gestalt
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
    if direction == :left
      dir = -1
    elsif direction == :right
      dir = 1
    end
    @walking = dir if @current_height_lvl > 0
    @gestalt.translate_by(Point2f.new(3*dir, 0))
  end

  protected

  def update_height_lvl
    @mutex.synchronize do
      if (@current_height_lvl <= JUMP_STEP_HEIGHT) && !@top_reached
        @current_height_lvl = @current_height_lvl + 1
        @gestalt.translate_by(Point2f.new(@walking, -JUMP_STEP_HEIGHT))
        true
      else
        @top_reached = true
        @current_height_lvl = @current_height_lvl - 1
        @gestalt.translate_by(Point2f.new(@walking, JUMP_STEP_HEIGHT))
        @top_reached = false if @current_height_lvl == 0
        @current_height_lvl != 0
      end
    end
  end

end
