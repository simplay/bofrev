require_relative 'layer'
require_relative 'game_settings'

# Layer Manager merges a set of layers to one grid that can be rendered.
class LayerManager
  def initialize(layer_count)
    @layers = []
    init_layers(layer_count)
  end

  def merged
    @layers.inject(Layer.new(GameSettings.width_pixels, GameSettings.height_pixels)) do |layer_merge, layer|
      layer_merge.overlayer_with(layer)
    end
  end

  private

  def init_layers(count)
    count.times do
      @layers << Layer.new(GameSettings.width_pixels, GameSettings.height_pixels)
    end
  end
end