require 'observable'
require 'event'
require 'point2f'

class Drawable

  # Every drawable instance, such as shapes, is supposed to be
  # observable. For example a ShapeManager observes shape instances in order
  # to detect collisions.
  include Observable

  # [Point2f] position in 2d world coordinates and
  # this drawable's barycenter.
  attr_reader :position

  # [Boolean] is it possible to draw this shape.
  # Is true if can be drawn, otherwise it is false.
  # E.g. in case this drawable is occluded then drawable is false.
  attr_accessor :drawable

  # @param position [Point2f] barycenter of this Drawable.
  # @param drawable [Boolean] should this shape be drawn?
  def initialize(position, drawable)
    @position = position
    @drawable = drawable
    @prev_value = Point2f.new
    @is_colliding = false
  end

  # Draw this shape onto a given canvas.
  #
  # @param canvas [Java::JavaAwt::Graphics]
  def draw_onto(canvas)
    raise "not implemented yet"
  end

  def update_animation_state
  end

  # @param other_drawable [Drawable] other drawable we test for a collision.
  def collide_with(other_drawable, at_position)
    raise "not implemented yet"
  end

  # Is this Drawable instance drawable.
  #
  # @return [Boolean] true if it should be drawn onto a Gui's canvas.
  def drawable?
    @drawable
  end

  def colliding?
    @is_colliding
  end

  def colliding!
    @is_colliding = true
  end

  # Translate this Drawable's (barycenter) position by a given value.
  #
  # @param value [Point2f] movement in x-and-y position.
  def translate_by(value)
    @is_colliding = false
    @prev_value = value
    @position.add(value)
    event = Event.new(:shape_movement, {:shift => value, :target => self})
    notify_all_with_message(event)
    # TODO: if collision, then @position.sub(value)
  end

  def undo_last_step
    @position.sub(@prev_value)
  end

end
