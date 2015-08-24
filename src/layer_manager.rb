require 'layer'

# foreground: moving player shape
# updated by player keyboard interactions.
# center: bot shapes /obstacles (such as plotforms) a player can interact with.
# updates by timer or by global.
# background: background animations no interactions possible.
# updated global ticker.
class LayerManager

  def initialize
    # hash key order determines the order of drawing:
    # first, the background layer will be drawn, then on top of that, the center layer. lastly, the foreground layer will be drawn.
    @layers = {
      :background => Layer.new,
      :center => Layer.new,
      :foreground => Layer.new
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
