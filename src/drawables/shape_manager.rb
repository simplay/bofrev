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
    @container << shape
  end

  def remove(shape)
    @container.delete(shape)
  end

  def empty?
    @container.blank?
  end

  def storage_count
    @container.count
  end

  # handle an event thrown by observed Observable.
  def handle_event
    raise "not implemented yet"
  end

  # @param message [Symbol] type of message.
  def handle_event_with(message)
    raise "not implemented yet"
  end

end
