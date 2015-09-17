require "test_helper"
require 'layer'
class TestLayerManager < Minitest::Test

  # allow to fetch puts outputs
  def fetch_stdout(&block)
    begin
      old_stdout = $stdout
      $stdout = StringIO.new('','w')
      yield block
      $stdout.string
    ensure
      $stdout = old_stdout
    end
  end

  class ADrawable
  end

  def setup
    LayerManager.class_eval do
      def layers
        @layers
      end
    end

    Layer.class_eval do
      def drawables
        @drawables
      end

      def state
        @state
      end

      def update_drawables
        @state = "update #{self.object_id}"
      end

      def draw_drawables_onto(g)
        @state = "draw #{self.object_id}"
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
    assert_equal(lm.layers.values[0].drawables, [])
    assert_equal(lm.layers.values[1].drawables, [])
    assert_equal(lm.layers.values[2].drawables, [])
  end

  def test_append_to
    lm = LayerManager.new
    a_drawable1 = ADrawable.new
    a_drawable2 = ADrawable.new
    a_drawable3 = ADrawable.new
    lm.append_to([a_drawable1, a_drawable2], :background)
    lm.append_to([a_drawable3], :foreground)
    assert(lm.layers.values[0].drawables.include?(a_drawable1))
    assert(lm.layers.values[0].drawables.include?(a_drawable2))
    assert_equal(lm.layers.values[0].drawables.count, 2)
    assert(lm.layers.values[2].drawables.include?(a_drawable3))
    assert_equal(lm.layers.values[2].drawables.count, 1)
  end

  def test_update_layer
    lm = LayerManager.new
    lm.update_layer(:center)
    expected = "update " + lm.layers.values[1].object_id.to_s
    given = lm.layers.values[1].state
    assert_equal(expected, given)
  end

  def test_draw_drawables_onto
    lm = LayerManager.new
    lm.draw_drawables_onto(nil)
    assert_equal(lm.layers.values[0].state, "draw " + lm.layers.values[0].object_id.to_s)
  end

  def test_draw_drawables_onto_for
    lm = LayerManager.new
    lm.draw_drawables_onto_for(nil, :center)
    assert_equal(lm.layers.values[1].state, "draw " + lm.layers.values[1].object_id.to_s)
  end

end
