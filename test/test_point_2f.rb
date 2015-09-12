require "minitest/autorun"

class TestPoint2f < Minitest::Test

  def test_initialize_default_value
    assert_equal(Point2f.new, Point2f.new(0,0))
  end

end
