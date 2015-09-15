require "test_helper"
require 'game_field_type_constants'

class TestColor < Minitest::Test

  def test_initialize_default_values_empty_case
    assert_equal(GameField.new.color, GameField::DEFAULT_COLOR)
    assert_equal(GameField.new.type, GameField::DEFAULT_TYPE)
    assert_equal(GameField.new.coordinates, GameField::DEFAULT_COORDS)
    assert_equal(GameField.new.value, GameField::DEFAULT_VALUE)
  end

  def test_initialize_default_only_color_assigned
    gf = GameField.new(Color.red)
    assert_equal(gf.color, Color.red)
    assert_equal(gf.type, GameField::DEFAULT_TYPE)
    assert_equal(gf.coordinates, GameField::DEFAULT_COORDS)
    assert_equal(gf.value, GameField::DEFAULT_VALUE)
  end

  def test_initialize_default_color_type_assigned
    gf = GameField.new(Color.red, GameFieldTypeConstants::BORDER)
    assert_equal(gf.color, Color.red)
    assert_equal(gf.type, GameFieldTypeConstants::BORDER)
    assert_equal(gf.coordinates, GameField::DEFAULT_COORDS)
    assert_equal(gf.value, GameField::DEFAULT_VALUE)
  end

  def test_initialize_default_color_type_coordinates_assigned
    gf = GameField.new(Color.red, GameFieldTypeConstants::BORDER, Point2f.new(12.2, -13.45))
    assert_equal(gf.color, Color.red)
    assert_equal(gf.type, GameFieldTypeConstants::BORDER)
    assert_equal(gf.coordinates, Point2f.new(12.2, -13.45))
    assert_equal(gf.value, GameField::DEFAULT_VALUE)
  end

  def test_initialize
    gf = GameField.new(Color.red, GameFieldTypeConstants::BORDER,
                       Point2f.new(12.2, -13.45), 5.4)
    assert_equal(gf.color, Color.red)
    assert_equal(gf.type, GameFieldTypeConstants::BORDER)
    assert_equal(gf.coordinates, Point2f.new(12.2, -13.45))
    assert_equal(gf.value, 5.4)
  end

end
