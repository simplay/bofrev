require "test_helper"

class TestLayerManager < Minitest::Test

  def setup
    LayerManager.class_eval do
      def layers
        @layers
      end
    end
  end

  def test_initialize
    lm = LayerManager.new
    assert_equal(lm.layers.count, 3)
    assert_equal(lm.layers.keys, [:background, :center, :foreground])
    assert(lm.layers.values[0].is_a?(Layer))
    assert(lm.layers.values[1].is_a?(Layer))
    assert(lm.layers.values[2].is_a?(Layer))
  end

end
