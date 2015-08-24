# A layer is a grid wrapper
class Layer

  def initialize
    @drawables = []
  end

  def append(drawable)
    @drawables << drawable
  end

  def update_drawables
    @drawables.each &:update_animation_state
  end

  def draw_drawables_onto(graphics)
    @drawables.each do |drawable|
      drawable.draw_onto(graphics) if drawable.drawable?
    end
  end

end
