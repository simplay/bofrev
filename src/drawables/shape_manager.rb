require 'pry'
require 'observer'

# Acts as a hierarchical freeform drawable datastructure.
# TODO: offer fast retrievals, generate a delta Grid to render from hierarchiaclly ordered freeforms.
# Currently an array (no intersection or occlusion tests possbile). Hence every contained instance gets rendered.
# Observes shapes
class ShapeManager < Observer

  def initialize
    @container = []
  end

  def shapes
    @container
  end

  def append(shape)
    shape.subscribe(self)
    @container << shape
  end

  def remove(shape)
    @container.delete(shape)
  end

  def empty?
    @container.empty?
  end

  def storage_count
    @container.count
  end

  # @param message [Symbol] type of message.
  def handle_event_with(message)
    target_shape = message.content[:target]
    shifted_position = message.content[:shift]

    collided_with = shapes_without(target_shape).select do |shape|
      target_shape.collide_with(shape, shifted_position)
    end
    target_shape.colliding!
    collided_with.each &:colliding!

    target_shape.undo_last_step unless collided_with.empty?
    # reset position for selected collided_with shapes (in case they are moveable)
    # handle different kinds of collisions, such as killed by player, walls, ...
  end

  protected

  def shapes_without(that_shape)
    non_hull_shapes = shapes.reject do |shape|
      shape.is_a?(QuadraticHullShape)
    end
    non_hull_shapes.reject do |shape|
      shape == that_shape
    end
  end

end
