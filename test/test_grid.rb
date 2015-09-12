require "minitest/autorun"

class TestGrid < Minitest::Test

  def setup
    @green = Color.green
    @white = Color.white
  end

  def test_initialize_dimensions
    m = 13; n = 22
    grid = Grid.new(m, n)
    assert_equal(grid.inner_width, m)
    assert_equal(grid.inner_height, n)
    assert_equal(grid.total_width, m+2)
    assert_equal(grid.total_height, n+2)
  end

  def test_intialize_4_neighborhood_assignment
    grid = Grid.new(1, 1)

    # center field
    assert_equal(grid.field_at(1,1).neighbors.count, 4)
    assert_equal(grid.field_at(0,1).object_id, grid.field_at(1,1).left.object_id)
    assert_equal(grid.field_at(2,1).object_id, grid.field_at(1,1).right.object_id)
    assert_equal(grid.field_at(1,2).object_id, grid.field_at(1,1).bottom.object_id)
    assert_equal(grid.field_at(1,0).object_id, grid.field_at(1,1).top.object_id)

    # corners
    assert_equal(grid.field_at(0,0).neighbors, [])
    assert_equal(grid.field_at(2,2).neighbors, [])
    assert_equal(grid.field_at(2,0).neighbors, [])
    assert_equal(grid.field_at(0,2).neighbors, [])

    # side edges
    assert_equal(grid.field_at(0,1).neighbors.count, 1)
    assert_equal(grid.field_at(1,1).object_id, grid.field_at(0,1).right.object_id)

    assert_equal(grid.field_at(2,1).neighbors.count, 1)
    assert_equal(grid.field_at(1,1).object_id, grid.field_at(2,1).left.object_id)

    assert_equal(grid.field_at(1,2).neighbors.count, 1)
    assert_equal(grid.field_at(1,1).object_id, grid.field_at(1,2).top.object_id)

    assert_equal(grid.field_at(1,0).neighbors.count, 1)
    assert_equal(grid.field_at(1,1).object_id, grid.field_at(1,0).bottom.object_id)
  end

  def test_intialize_8_neighborhood_assignment
    grid = Grid.new(1, 1)

    # center field
    assert_equal(grid.field_at(1,1).neighbors_8.count, 8)
    assert_equal(grid.field_at(0,1).object_id, grid.field_at(1,1).left.object_id)
    assert_equal(grid.field_at(2,1).object_id, grid.field_at(1,1).right.object_id)
    assert_equal(grid.field_at(1,2).object_id, grid.field_at(1,1).bottom.object_id)
    assert_equal(grid.field_at(1,0).object_id, grid.field_at(1,1).top.object_id)

    assert_equal(grid.field_at(0,0).object_id, grid.field_at(1,1).top_left.object_id)
    assert_equal(grid.field_at(2,0).object_id, grid.field_at(1,1).top_right.object_id)
    assert_equal(grid.field_at(0,2).object_id, grid.field_at(1,1).bottom_left.object_id)
    assert_equal(grid.field_at(2,2).object_id, grid.field_at(1,1).bottom_right.object_id)

    # corners
    assert_equal(grid.field_at(0,0).neighbors_8.count, 1)
    assert_equal(grid.field_at(1,1).object_id, grid.field_at(0,0).bottom_right.object_id)

    assert_equal(grid.field_at(2,2).neighbors_8.count, 1)
    assert_equal(grid.field_at(1,1).object_id, grid.field_at(2,2).top_left.object_id)

    assert_equal(grid.field_at(2,0).neighbors_8.count, 1)
    assert_equal(grid.field_at(1,1).object_id, grid.field_at(2,0).bottom_left.object_id)

    assert_equal(grid.field_at(0,2).neighbors_8.count, 1)
    assert_equal(grid.field_at(1,1).object_id, grid.field_at(0,2).top_right.object_id)

    # side edges
    assert_equal(grid.field_at(0,1).neighbors_8.count, 1)
    assert_equal(grid.field_at(1,1).object_id, grid.field_at(0,1).right.object_id)

    assert_equal(grid.field_at(2,1).neighbors_8.count, 1)
    assert_equal(grid.field_at(1,1).object_id, grid.field_at(2,1).left.object_id)

    assert_equal(grid.field_at(1,2).neighbors_8.count, 1)
    assert_equal(grid.field_at(1,1).object_id, grid.field_at(1,2).top.object_id)

    assert_equal(grid.field_at(1,0).neighbors_8.count, 1)
    assert_equal(grid.field_at(1,1).object_id, grid.field_at(1,0).bottom.object_id)
  end

  def test_set_field_value
    grid = Grid.new(1, 1)
    grid.set_field_value_at(1,1, 1337)
    assert_equal(grid.field_at(1,1).value, 1337)
  end

  def test_set_field_color
    grid = Grid.new(1, 1)
    grid.set_field_color_at(1,1, @green)
    assert_equal(grid.field_at(1,1).color, @green)
  end

  def test_copy
    grid = Grid.new(1, 1)
    other_grid = Grid.new(1, 1)

    grid.set_field_value_at(1,1, 1337)
    grid.set_field_color_at(1,1,@green)

    assert_equal(grid.field_at(1,1).value, 1337)
    assert_equal(grid.field_at(1,1).color, @green)

    assert_equal(other_grid.field_at(1,1).value, 0)
    assert_equal(other_grid.field_at(1,1).color, @white)

    other_grid.overwrite_us_with(grid)
    assert_equal(other_grid.field_at(1,1).value, 1337)
    assert_equal(other_grid.field_at(1,1).color, @green)
  end

  def test_summing_neighborhood_values
    grid = Grid.new(3, 3)
    grid.set_field_value_at(2,1,1)
    grid.set_field_value_at(1,2,1)
    grid.set_field_value_at(2,3,1)
    grid.set_field_value_at(3,2,1)
    grid.set_field_value_at(3,3,1)
    grid.set_field_value_at(1,1,1)
    grid.set_field_value_at(3,1,1)
    grid.set_field_value_at(1,3,1)

    assert_equal(grid.field_at(2,2).sum_8_neighbor_values, 8)
  end

end
