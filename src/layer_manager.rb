require 'layer'

class LayerManager

  def initialize
    @layers = {
      :foreground => Layer.new,
      :background => Layer.new
    }
  end

  # Append a set of drawable instances to a target layer,
  #
  # @param drawables [Array] of type Drawable.
  # @param layer_type [Symbol] identifier of target layer.
  def append_to(drawables, layer_type)
    drawables.each do |drawable|
      layer_with(layer_type).append(drawable)
    end
  end

  def update_layer(layer_type)
    layer_with(layer_type).update_drawables
  end

  def draw_drawables_onto(graphics)
    @layers.values.each do |layer|
      layer.draw_drawables_onto(graphics)
    end
  end

  protected

  def layer_with(layer_type)
    @layers[layer_type]
  end

end
