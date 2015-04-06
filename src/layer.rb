# A layer is a grid wrapper
class Layer
  def initialize(width, height)
    @width = width; @height = height
    @grid = Grid.new(width, height)
    @prev_iter_grid = Grid.new(width, height)
  end

  def grid
    @grid
  end

  def prev_grid
    @prev_iter_grid
  end

  def overlayer_with(other)
    grid.each_with_index do |cell, idx|
      if cell.free?
        x = idx % width
        y = idx / height.to_i
        other_cell = other.field_at(x, y)
        cell.color = other_cell.color
        cell.value = other_cell.value
        cell.type = other_cell.type
      end
    end
  end

end