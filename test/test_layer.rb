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

  def test_drawables
    layer = Layer.new
    d1 = ANewDrawableL.new
    d2 = ANewDrawableL.new
    d3 = ANewDrawableL.new
    layer.append(d1)
    layer.append(d2)
    layer.append(d3)
    assert_equal(layer.drawables, [d1,d2,d3])
  end

end
