require "test_helper"

class TestLayer < Minitest::Test

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

  class ANewDrawable
    def initialize(id="")
      @id = id
    end

    def drawable?
      true
    end

    def state
      @state
    end

    def id
      @id
    end

    def update_animation_state
      @state =  "#{object_id}-#{id}"
    end

    def draw_onto(g)
      @state =  "drawing #{id}"
    end

  end

  def setup
    Layer.class_eval do
      def drawables
        @drawables
      end
    end
  end

  def test_initialize
    assert_equal(Layer.new.drawables, [])
  end

  def test_append
    layer = Layer.new
    layer.append(ANewDrawable.new)
    assert_equal(layer.drawables.count, 1)
    layer.append(ANewDrawable.new)
    assert_equal(layer.drawables.count, 2)
  end

  def test_update_drawables
    layer = Layer.new
    layer.append(ANewDrawable.new("obj1"))
    layer.update_drawables
    expected = "#{layer.drawables[0].object_id}-#{layer.drawables[0].id}"
    assert_equal(expected, layer.drawables.first.state)
  end

  def test_draw_drawables_onto
    layer = Layer.new
    layer.append(ANewDrawable.new("obj1"))
    layer.draw_drawables_onto(nil)
    assert_equal(layer.drawables.first.state, "drawing obj1")
  end
end
