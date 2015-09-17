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

  class ANewDrawableL
    def initialize(id="")
      @id = id
      @state = "init"
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
      @state = "#{id}"
    end

    def draw_onto(g)
      @state = "drawing #{id}"
    end

  end

  def test_initialize
    assert_equal(Layer.new.drawables, [])
  end

  def test_append
    layer = Layer.new
    layer.append(ANewDrawableL.new)
    assert_equal(layer.drawables.count, 1)
    layer.append(ANewDrawableL.new)
    assert_equal(layer.drawables.count, 2)
  end

end
