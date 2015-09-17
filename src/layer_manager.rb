require 'layer'

# LayerManager is responsible for managing different Layer instances that have some
# role associated with. Currently, the following Layer roles are defined:
#   foreground layers: moving player shape
#     updated by player keyboard interactions.
#   center: bot shapes /obstacles (such as plotforms) a player can interact with.
#     updates by timer or by global.
#   background: background animations no interactions possible.
#     updated global ticker.
class LayerManager

  # Define a Hash called @layers containing different types of layers.
  #
  # @hint: The hash key order in @layers determines the order of drawing:
  #   first, the background layer will be drawn,
  #   then on top of that, the center layer.
  #   lastly, the foreground layer will be drawn.
  def initialize
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

  # Update all Drawable instances that are appended to a target layer
  # selected by a given layer type from @layers.
  #
  # @param layer_type [Symbol] layer key of target layer.
  def update_layer(layer_type)
    layer_with(layer_type).update_drawables
  end

  # Draw all Drawables contained in the layers of this LayerManager.
  #
  # @param graphics [Java::Graphics] target Awt graphics object
  def draw_drawables_onto(graphics)
    @layers.values.each do |layer|
      layer.draw_drawables_onto(graphics)
    end
  end

  # Draw all drawables that live in a target layer with a certain layer type.
  #
  # @param graphics [Java::Graphics] target Awt graphics object
  # @param layer_type [Symbol] layer key of target layer.
  def draw_drawables_onto_for(graphics, layer_type)
    layer_with(layer_type).draw_drawables_onto(graphics)
  end

  protected

  # Retrieve the target layer with a certain layer type.
  # @example layer_with(:center) gives the Layer instance
  #   that belongs to the Hash key :center in @layer.
  # @param layer_type [Symbol] key in @layers identifying the target layer.
  # @return [Layer] that belongs to the given layer_type argument.
  def layer_with(layer_type)
    @layers[layer_type]
  end

end
