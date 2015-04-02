require_relative '../src/grid'
require 'pry'

describe Grid do

  it 'should have total width of M+2 and total height of N+2' do
    m = 13; n = 22;
    grid = Grid.new(m, n)
    expect(grid.inner_width).to eq(m)
    expect(grid.inner_height).to eq(n)
    expect(grid.total_width).to eq(m+2)
    expect(grid.total_height).to eq(n+2)
  end

  it 'should have correct 4-neighborhood' do
    grid = Grid.new(1, 1)

    # center field
    expect(grid.field_at(1,1).neighbors.count).to eq(4)
    expect(grid.field_at(0,1).object_id).to eq(grid.field_at(1,1).left.object_id)
    expect(grid.field_at(2,1).object_id).to eq(grid.field_at(1,1).right.object_id)
    expect(grid.field_at(1,2).object_id).to eq(grid.field_at(1,1).bottom.object_id)
    expect(grid.field_at(1,0).object_id).to eq(grid.field_at(1,1).top.object_id)

    # corners
    expect(grid.field_at(0,0).neighbors).to eq([])
    expect(grid.field_at(2,2).neighbors).to eq([])
    expect(grid.field_at(2,0).neighbors).to eq([])
    expect(grid.field_at(0,2).neighbors).to eq([])

    # side edges
    expect(grid.field_at(0,1).neighbors.count).to eq(1)
    expect(grid.field_at(1,1).object_id).to eq(grid.field_at(0,1).right.object_id)

    expect(grid.field_at(2,1).neighbors.count).to eq(1)
    expect(grid.field_at(1,1).object_id).to eq(grid.field_at(2,1).left.object_id)

    expect(grid.field_at(1,2).neighbors.count).to eq(1)
    expect(grid.field_at(1,1).object_id).to eq(grid.field_at(1,2).top.object_id)

    expect(grid.field_at(1,0).neighbors.count).to eq(1)
    expect(grid.field_at(1,1).object_id).to eq(grid.field_at(1,0).bottom.object_id)

  end

  it 'should have correct 8-neighborhood' do
    grid = Grid.new(1, 1)

    # center field
    expect(grid.field_at(1,1).neighbors_8.count).to eq(8)
    expect(grid.field_at(0,1).object_id).to eq(grid.field_at(1,1).left.object_id)
    expect(grid.field_at(2,1).object_id).to eq(grid.field_at(1,1).right.object_id)
    expect(grid.field_at(1,2).object_id).to eq(grid.field_at(1,1).bottom.object_id)
    expect(grid.field_at(1,0).object_id).to eq(grid.field_at(1,1).top.object_id)

    expect(grid.field_at(0,0).object_id).to eq(grid.field_at(1,1).top_left.object_id)
    expect(grid.field_at(2,0).object_id).to eq(grid.field_at(1,1).top_right.object_id)
    expect(grid.field_at(0,2).object_id).to eq(grid.field_at(1,1).bottom_left.object_id)
    expect(grid.field_at(2,2).object_id).to eq(grid.field_at(1,1).bottom_right.object_id)


    # corners
    expect(grid.field_at(0,0).neighbors_8.count).to eq(1)
    expect(grid.field_at(1,1).object_id).to eq(grid.field_at(0,0).bottom_right.object_id)

    expect(grid.field_at(2,2).neighbors_8.count).to eq(1)
    expect(grid.field_at(1,1).object_id).to eq(grid.field_at(2,2).top_left.object_id)

    expect(grid.field_at(2,0).neighbors_8.count).to eq(1)
    expect(grid.field_at(1,1).object_id).to eq(grid.field_at(2,0).bottom_left.object_id)

    expect(grid.field_at(0,2).neighbors_8.count).to eq(1)
    expect(grid.field_at(1,1).object_id).to eq(grid.field_at(0,2).top_right.object_id)

    # side edges
    expect(grid.field_at(0,1).neighbors_8.count).to eq(1)
    expect(grid.field_at(1,1).object_id).to eq(grid.field_at(0,1).right.object_id)

    expect(grid.field_at(2,1).neighbors_8.count).to eq(1)
    expect(grid.field_at(1,1).object_id).to eq(grid.field_at(2,1).left.object_id)

    expect(grid.field_at(1,2).neighbors_8.count).to eq(1)
    expect(grid.field_at(1,1).object_id).to eq(grid.field_at(1,2).top.object_id)

    expect(grid.field_at(1,0).neighbors_8.count).to eq(1)
    expect(grid.field_at(1,1).object_id).to eq(grid.field_at(1,0).bottom.object_id)
  end

  it 'should be possible to write a GameField in a Grid' do
    grid = Grid.new(1, 1)
    grid.set_field_value_at(1,1, 1337)
    grid.set_field_color_at(1,1, 'green')
    expect(grid.field_at(1,1).value).to eq(1337)
    expect(grid.field_at(1,1).color).to eq('green')
  end

  it 'should be possible to successfully copy the state from one grid into another' do
    grid = Grid.new(1, 1)
    other_grid = Grid.new(1, 1)

    grid.set_field_value_at(1,1, 1337)
    grid.set_field_color_at(1,1, 'green')

    expect(grid.field_at(1,1).value).to eq(1337)
    expect(grid.field_at(1,1).color).to eq('green')

    expect(other_grid.field_at(1,1).value).to eq(0)
    expect(other_grid.field_at(1,1).color).to eq('white')

    other_grid.overwrite_us_with(grid)
    expect(other_grid.field_at(1,1).value).to eq(1337)
    expect(other_grid.field_at(1,1).color).to eq('green')
  end

  it 'correct neighborhood sum' do
    grid = Grid.new(3, 3)
    grid.set_field_value_at(2,1,1)
    grid.set_field_value_at(1,2,1)
    grid.set_field_value_at(2,3,1)
    grid.set_field_value_at(3,2,1)
    grid.set_field_value_at(3,3,1)
    grid.set_field_value_at(1,1,1)
    grid.set_field_value_at(3,1,1)
    grid.set_field_value_at(1,3,1)

    expect(grid.field_at(2,2).sum_8_neighbor_values).to eq(8)
  end

end