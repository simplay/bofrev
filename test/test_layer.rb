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

    def id
      @id
    end

    def update_animation_state
      puts "#{object_id}-#{id}"
    end

    def draw_onto(g)
      puts "drawing #{id}"
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
    layer.append(ANewDrawable.new("obj2"))
    layer.append(ANewDrawable.new("obj3"))
    out = fetch_stdout {layer.update_drawables}
    assert(out.include?("#{layer.drawables[0].object_id}-#{layer.drawables[0].id}"))
    assert(out.include?("#{layer.drawables[1].object_id}-#{layer.drawables[1].id}"))
    assert(out.include?("#{layer.drawables[2].object_id}-#{layer.drawables[2].id}"))
  end

  def test_draw_drawables_onto
    layer = Layer.new
    layer.append(ANewDrawable.new("obj1"))
    layer.append(ANewDrawable.new("obj2"))
    layer.append(ANewDrawable.new("obj3"))
    out = fetch_stdout {layer.draw_drawables_onto(nil)}
    assert(out.include?("drawing obj1"))
    assert(out.include?("drawing obj2"))
    assert(out.include?("drawing obj3"))
  end
end
