# Acts as a hierarchical freeform drawable datastructure.
# TODO: offer fast retrievals, generate a delta Grid to render from hierarchiaclly ordered freeforms.
# Currently an array (no intersection or occlusion tests possbile). Hence every contained instance gets rendered.
class ShapeManager

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

end
