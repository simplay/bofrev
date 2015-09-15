require "test_helper"
require 'game_field_type_constants'

class TestGameField < Minitest::Test

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

  def test_column_idx
    x = 23; y = 67
    gf = GameField.new(Color.red, GameFieldTypeConstants::BORDER,
                       Point2f.new(x, y))
    assert_equal(gf.coordinates.y-1, gf.column_idx)
    assert_equal(y-1, gf.column_idx)
  end

  def test_row_idx
    x = 23; y = 67
    gf = GameField.new(Color.red, GameFieldTypeConstants::BORDER,
                       Point2f.new(x, y))
    assert_equal(gf.coordinates.x-1, gf.row_idx)
    assert_equal(x-1, gf.row_idx)
  end

  def test_assign_neighbordhood
    neighbors = {
      :left => GameField.new,
      :right => GameField.new,
      :top => GameField.new,
      :bottom => GameField.new,
      :bottom_left => GameField.new,
      :bottom_right => GameField.new,
      :top_right => GameField.new,
      :top_left => GameField.new
    }
    gf = GameField.new
    gf.assign_neighborhood(neighbors)
    assert_equal(gf.left.object_id, neighbors[:left].object_id)
    assert_equal(gf.left.right.object_id, gf.object_id)
    assert_equal(gf.right.object_id, neighbors[:right].object_id)
    assert_equal(gf.right.left.object_id, gf.object_id)
    assert_equal(gf.top.object_id, neighbors[:top].object_id)
    assert_equal(gf.top.bottom.object_id, gf.object_id)
    assert_equal(gf.bottom.object_id, neighbors[:bottom].object_id)
    assert_equal(gf.bottom.top.object_id, gf.object_id)
    assert_equal(gf.top_left.object_id, neighbors[:top_left].object_id)
    assert_equal(gf.top_left.bottom_right.object_id, gf.object_id)
    assert_equal(gf.top_right.object_id, neighbors[:top_right].object_id)
    assert_equal(gf.top_right.bottom_left.object_id, gf.object_id)
    assert_equal(gf.bottom_left.object_id, neighbors[:bottom_left].object_id)
    assert_equal(gf.bottom_left.top_right.object_id, gf.object_id)
    assert_equal(gf.bottom_right.object_id, neighbors[:bottom_right].object_id)
    assert_equal(gf.bottom_right.top_left.object_id, gf.object_id)
  end

  def test_neighbors
    neighbors = {
      :left => GameField.new,
      :right => GameField.new,
      :top => GameField.new,
      :bottom => GameField.new,
      :bottom_left => GameField.new,
      :bottom_right => GameField.new,
      :top_right => GameField.new,
      :top_left => GameField.new
    }
    gf = GameField.new
    gf.assign_neighborhood(neighbors)
    assert_equal(gf.neighbors[0], neighbors[:right])
    assert_equal(gf.neighbors[1], neighbors[:bottom])
    assert_equal(gf.neighbors[2], neighbors[:left])
    assert_equal(gf.neighbors[3], neighbors[:top])
  end

  def test_neighbors_8
    neighbors = {
      :left => GameField.new,
      :right => GameField.new,
      :top => GameField.new,
      :bottom => GameField.new,
      :bottom_left => GameField.new,
      :bottom_right => GameField.new,
      :top_right => GameField.new,
      :top_left => GameField.new
    }
    gf = GameField.new
    gf.assign_neighborhood(neighbors)
    assert_equal(gf.neighbors_8[0], neighbors[:top_left])
    assert_equal(gf.neighbors_8[1], neighbors[:top])
    assert_equal(gf.neighbors_8[2], neighbors[:top_right])
    assert_equal(gf.neighbors_8[3], neighbors[:left])
    assert_equal(gf.neighbors_8[4], neighbors[:right])
    assert_equal(gf.neighbors_8[5], neighbors[:bottom_left])
    assert_equal(gf.neighbors_8[6], neighbors[:bottom])
    assert_equal(gf.neighbors_8[7], neighbors[:bottom_right])
  end

  def test_sum_8_neighbor_values
    color = GameField::DEFAULT_COLOR
    type = GameField::DEFAULT_TYPE
    coords = GameField::DEFAULT_COORDS

    neighbors = {
      :left => GameField.new(color, type, coords, rand),
      :right => GameField.new(color, type, coords, rand),
      :top => GameField.new(color, type, coords, rand),
      :bottom => GameField.new(color, type, coords, rand),
      :bottom_left => GameField.new(color, type, coords, rand),
      :bottom_right => GameField.new(color, type, coords, rand),
      :top_right => GameField.new(color, type, coords, rand),
      :top_left => GameField.new(color, type, coords, rand)
    }
    gf = GameField.new
    gf.assign_neighborhood(neighbors)

    total = neighbors.values.inject(0.0) {|sum, field| sum + field.value}
    assert_in_delta(gf.sum_8_neighbor_values, total, 0.001)
  end

  def test_each
    color = GameField::DEFAULT_COLOR
    type = GameField::DEFAULT_TYPE
    coords = GameField::DEFAULT_COORDS

    neighbors = {
      :left => GameField.new(color, type, coords, rand),
      :right => GameField.new(color, type, coords, rand),
      :top => GameField.new(color, type, coords, rand),
      :bottom => GameField.new(color, type, coords, rand),
      :bottom_left => GameField.new(color, type, coords, rand),
      :bottom_right => GameField.new(color, type, coords, rand),
      :top_right => GameField.new(color, type, coords, rand),
      :top_left => GameField.new(color, type, coords, rand)
    }
    gf = GameField.new
    gf.assign_neighborhood(neighbors)

    total = 0
    gf.each do |field|
      total = total + field.value
    end

    total_alias = 0
    gf.each_neighbor do |field|
      total_alias = total_alias + field.value
    end

    assert_in_delta(total, gf.sum_8_neighbor_values, 0.0001)
    assert_equal(total_alias, total)
    assert_equal(gf.each.first, gf.neighbors_8.first)
  end

  def test_each_4_neighborhood
    color = GameField::DEFAULT_COLOR
    type = GameField::DEFAULT_TYPE
    coords = GameField::DEFAULT_COORDS

    neighbors = {
      :left => GameField.new(color, type, coords, rand),
      :right => GameField.new(color, type, coords, rand),
      :top => GameField.new(color, type, coords, rand),
      :bottom => GameField.new(color, type, coords, rand),
      :bottom_left => GameField.new(color, type, coords, rand),
      :bottom_right => GameField.new(color, type, coords, rand),
      :top_right => GameField.new(color, type, coords, rand),
      :top_left => GameField.new(color, type, coords, rand)
    }
    gf = GameField.new
    gf.assign_neighborhood(neighbors)

    fetched_neighbors = []
    gf.each(:neighbors) do |field|
      fetched_neighbors << field
    end
    fetched_neighbors_alias = []
    gf.each_neighbor(:neighbors) do |field|
      fetched_neighbors_alias << field
    end
    assert_equal(fetched_neighbors, gf.neighbors)
    assert_equal(fetched_neighbors, fetched_neighbors_alias)
  end

  def test_neighbors?
    neighbors = {
      :left => GameField.new,
      :right => GameField.new,
      :top => GameField.new,
      :bottom => GameField.new,
      :bottom_left => GameField.new,
      :bottom_right => GameField.new,
      :top_right => GameField.new,
      :top_left => GameField.new
    }
    gf = GameField.new
    gf.assign_neighborhood(neighbors)
    gf2 = GameField.new
    assert(gf.neighbors?)
    assert_equal(gf2.neighbors?, false)
  end

  def test_fulfills_any?
    fulfilling_gf = GameField.new
    not_fullfilling_gf = GameField.new(Color.red, :foobar)
    check_list = [GameFieldTypeConstants::BORDER, GameFieldTypeConstants::FREE, :pew]
    assert(fulfilling_gf.fulfills_any?(check_list))
    assert_equal(not_fullfilling_gf.fulfills_any?(check_list), false)
  end

  def test_to_i
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::BORDER).to_i, 2)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::GROUND_BORDER).to_i, 3)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::PLACED).to_i, 4)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::MOVING).to_i, 1)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::FREE).to_i, 0)
  end

  def test_drawable?
    assert(GameField.new(Color.red, GameFieldTypeConstants::BORDER).drawable?)
    assert(GameField.new(Color.red, GameFieldTypeConstants::PLACED).drawable?)
    assert(GameField.new(Color.red, GameFieldTypeConstants::MOVING).drawable?)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::FREE).drawable?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::GROUND_BORDER).drawable?, false)
  end

  def test_moving?
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::BORDER).moving?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::PLACED).moving?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::MOVING).moving?, true)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::FREE).moving?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::GROUND_BORDER).moving?, false)
  end

  def test_free?
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::BORDER).free?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::PLACED).free?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::MOVING).free?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::FREE).free?, true)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::GROUND_BORDER).free?, false)
  end

  def test_placed?
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::BORDER).placed?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::PLACED).placed?, true)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::MOVING).placed?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::FREE).placed?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::GROUND_BORDER).placed?, false)
  end

  def test_border?
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::BORDER).border?, true)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::PLACED).border?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::MOVING).border?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::FREE).border?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::GROUND_BORDER).border?, false)
  end

  def test_floor?
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::BORDER).floor?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::PLACED).floor?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::MOVING).floor?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::FREE).floor?, false)
    assert_equal(GameField.new(Color.red, GameFieldTypeConstants::GROUND_BORDER).floor?, true)
  end

  def test_to_s
    type = :foobar; color = Color.green
    gf = GameField.new(color, type)
    assert_equal("t:#{type} c:#{color.to_rgb}", gf.to_s)
  end

  def test_wipe_out
    type = :foobar; color = Color.green
    gf = GameField.new(color, type)
    assert_equal(gf.color, color)
    assert_equal(gf.type, type)
    gf.wipe_out
    assert_equal(gf.color, GameField::DEFAULT_COLOR)
    assert_equal(gf.type, GameField::DEFAULT_TYPE)
  end

  def test_copy_state_from
    type = :foobar; color = Color.green
    other = GameField.new(color, type)
    gf = GameField.new
    assert_equal(other.color, color)
    assert_equal(other.type, type)
    assert_equal(gf.color, GameField::DEFAULT_COLOR)
    assert_equal(gf.type, GameField::DEFAULT_TYPE)
    gf.copy_state_from(other)
    assert_equal(gf.color, color)
    assert_equal(gf.type, type)
  end

end
