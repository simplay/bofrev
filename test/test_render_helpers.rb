require "test_helper"

class TestRenderHelpers < Minitest::Test

  def setup
    GameSettings.build_from
    @arhi = ARenderHelperIncluder.new
  end

  def test_inclusion
    assert_includes(ARenderHelperIncluder, RenderHelpers)
  end

  def test_cell_size
    assert_equal(@arhi.cell_size, GameSettings.cell_size)
  end

  def test_width_pixels
    assert_equal(@arhi.width_pixels, GameSettings.width_pixels)
  end

  def test_height_pixels
    assert_equal(@arhi.height_pixels, GameSettings.height_pixels)
  end

  def test_x_pixels
    assert_equal(@arhi.x_pixels, GameSettings.width_pixels + 2)
  end

  def test_y_pixels
    assert_equal(@arhi.y_pixels, GameSettings.height_pixels + 2)
  end

  def test_inner_x_pixels
    expected = GameSettings.max_width / GameSettings.cell_size
    assert_equal(@arhi.inner_x_pixels, expected)
  end

  def test_inner_y_pixels
    expected = GameSettings.max_height / GameSettings.cell_size
    assert_equal(@arhi.inner_y_pixels, expected)
  end

  def test_x_iter
    expected = (1..GameSettings.width_pixels)
    assert_equal(@arhi.x_iter, expected)
  end

  def test_y_iter
    expected = (1..GameSettings.height_pixels)
    assert_equal(@arhi.y_iter, expected)
  end

end
