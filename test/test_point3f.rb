require "test_helper"

class TestPoint3f < Minitest::Test

  def test_initialize_default_value
    assert_equal(Point3f.new, Point3f.new(0,0,0))
  end

  def test_accessors
    x = rand; y = rand; z = rand
    p = Point3f.new(x, y, z)
    assert_equal(p.x, x)
    assert_equal(p.y, y)
    assert_equal(p.z, z)
  end

  def test_copy
    x = rand; y = rand; z = rand
    p = Point3f.new(x, y, z)
    assert_equal(p.copy.x, x)
    assert_equal(p.copy.y, y)
    assert_equal(p.copy.z, z)
  end

  def test_add
    x1 = rand; y1 = rand; z1 = rand
    p1 = Point3f.new(x1, y1, z1)
    x2 = rand; y2 = rand; z2 = rand
    p2 = Point3f.new(x2, y2, z2)
    p1.add(p2)
    assert_equal(p1.x, x1+x2)
    assert_equal(p1.y, y1+y2)
    assert_equal(p1.z, z1+z2)
  end

  def test_sub
    x1 = rand; y1 = rand; z1 = rand
    p1 = Point3f.new(x1, y1, z1)
    x2 = rand; y2 = rand; z2 = rand
    p2 = Point3f.new(x2, y2, z2)
    p1.sub(p2)
    assert_equal(p1.x, x1-x2)
    assert_equal(p1.y, y1-y2)
    assert_equal(p1.z, z1-z2)
  end

  def test_scale_by
    x = rand; y = rand; z = rand
    p = Point3f.new(x, y, z)
    s = rand
    p.scale_by(s)
    assert_equal(p.x, s*x)
    assert_equal(p.y, s*y)
    assert_equal(p.z, s*z)
  end

  def test_to_s
    x = rand; y = rand; z = rand
    p = Point3f.new(x, y, z)
    assert_equal(p.to_s, "p=(#{x}, #{y}, #{z})")
  end

  def test_equality
    x1 = rand; y1 = rand; z1 = rand
    p1 = Point3f.new(x1, y1, z1)
    x2 = rand; y2 = rand; z2 = rand
    p2 = Point3f.new(x2, y2, z2)
    assert_equal(p1 == p2, false)
    assert_equal(p1, p1)
    assert_equal(p2, p2)
  end

end
