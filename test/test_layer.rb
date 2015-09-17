require "test_helper"

class TestLayer < Minitest::Test

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
