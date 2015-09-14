require "test_helper"

class TestPoint2f < Minitest::Test

  def test_initialize_default_value
    assert_equal(Point2f.new, Point2f.new(0,0))
  end

  def test_accessors
    x = rand; y = rand
    p = Point2f.new(x, y)
    assert_equal(p.x, x)
    assert_equal(p.y, y)
  end

  def test_copy
    x = rand; y = rand
    p = Point2f.new(x, y)
    assert_equal(p.copy.x, x)
    assert_equal(p.copy.y, y)
  end

  def test_add
    x1 = rand; y1 = rand
    p1 = Point2f.new(x1, y1)
    x2 = rand; y2 = rand
    p2 = Point2f.new(x2, y2)
    p1.add(p2)
    assert_equal(p1.x, x1+x2)
    assert_equal(p1.y, y1+y2)
  end

  def test_sub
    x1 = rand; y1 = rand
    p1 = Point2f.new(x1, y1)
    x2 = rand; y2 = rand
    p2 = Point2f.new(x2, y2)
    p1.sub(p2)
    assert_equal(p1.x, x1-x2)
    assert_equal(p1.y, y1-y2)
  end

  def test_scale_by
    x = rand; y = rand
    p = Point2f.new(x, y)
    s = rand
    p.scale_by(s)
    assert_equal(p.x, s*x)
    assert_equal(p.y, s*y)
  end

  def test_to_s
    x = rand; y = rand
    p = Point2f.new(x, y)
    assert_equal(p.to_s, "p=(#{x}, #{y})")
  end

  def test_length
    x = rand; y = rand
    p = Point2f.new(x, y)
    assert_equal(p.length, Math.sqrt(x*x+y*y))
  end

  def test_direction_to
    x1 = rand; y1 = rand
    p1 = Point2f.new(x1, y1)
    x2 = rand; y2 = rand
    p2 = Point2f.new(x2, y2)
    assert_equal(p1.direction_to(p2).x, Point2f.new(x1-x2, y1-y2).x)
    assert_equal(p1.direction_to(p2).y, Point2f.new(x1-x2, y1-y2).y)
  end

  def test_distance_to
    x1 = rand; y1 = rand
    p1 = Point2f.new(x1, y1)
    x2 = rand; y2 = rand
    p2 = Point2f.new(x2, y2)
    dist = Math.sqrt((x1-x2)**2 + (y1-y2)**2)
    assert_equal(p1.distance_to(p2), dist)
  end

  def test_equality
    x1 = rand; y1 = rand
    p1 = Point2f.new(x1, y1)
    x2 = rand; y2 = rand
    p2 = Point2f.new(x2, y2)
    assert_equal(p1 == p2, false)
    assert_equal(p1, p1)
    assert_equal(p2, p2)
  end

end
