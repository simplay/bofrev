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

  it 'should have correct neighborhood' do
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

end