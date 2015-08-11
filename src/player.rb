require 'drawables/shape'
require 'point2f'
require 'hull'

class Player

  IS_DEBUG_MODE = true
  JUMP_STEP_HEIGHT = 8

  def initialize
    @gestalt = Shape.new
    @current_height_lvl = 0
    @is_jumping = false
    @is_walking = false
    @is_falling = false
    @steps_to_walk = 0
    @top_reached = false
    @mutex = Mutex.new
    @hull = Hull.new(@gestalt, IS_DEBUG_MODE)
  end

  def gestalt
    @gestalt
  end

  def hull_gestalt
    @hull.gestalt
  end

  def update_position
    jump if jumping? && not_falling?
    walk(@direction) if walking?
  end

  def jump
    @is_jumping = update_height_lvl
  end

  def jumping?
    @is_jumping
  end

  def falling?
    @is_falling
  end

  def walking?
    @is_walking
  end

  def not_falling?
    !falling?
  end

  def stop_walking
    @is_walking = false
    @steps_to_walk = 0
  end

  def walk(direction)
    @is_walking = true
    @direction = direction
    if direction == :left
      dir = -1
    elsif direction == :right
      dir = 1
    end
    @steps_to_walk = 3*dir
    @gestalt.translate_by(Point2f.new(@steps_to_walk, 0))
  end

  def to_s
    "walking:#{@is_walking} jumping:#{@is_jumping} falling:#{@is_falling}"
  end

  protected

  def update_height_lvl
    @mutex.synchronize do
      if (@current_height_lvl <= JUMP_STEP_HEIGHT) && !@top_reached
        @current_height_lvl = @current_height_lvl + 1
        @gestalt.translate_by(Point2f.new(@steps_to_walk, -JUMP_STEP_HEIGHT))
        true
      else
        @top_reached = true
        @current_height_lvl = @current_height_lvl - 1
        @gestalt.translate_by(Point2f.new(@steps_to_walk, JUMP_STEP_HEIGHT))
        @top_reached = false if @current_height_lvl == 0
        @current_height_lvl != 0
      end
    end
  end

end
