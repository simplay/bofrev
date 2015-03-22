require_relative 'game_field'
require_relative 'settings'

class Map

  include Settings

  def initialize
    @grid = []
    y_pixels.times do
      row = []
      x_pixels.times do
        row << GameField.new
      end
      @grid << row
    end





    # setup x border
    x_pixels.times do |idx|
      @grid[0][idx] = GameField.new('black', :border)
      @grid[y_pixels-1][idx] = GameField.new('black', :ground_border)
    end

    # setup y border
    y_pixels.times do |idy|
      @grid[idy][0] = GameField.new('black', :border)
      @grid[idy][x_pixels-1] = GameField.new('black', :border)
    end

    spawn_new_shape
  end

  def spawn_new_shape
    @shape = Shape.new(self, random_color)
  end

  # Retrieve a map field at a provided position.
  #
  # @param idx [Integer] column index in grid using matrix convention
  # @param idy [Integer] row index in grid using matrix convention
  # @return [GameField] field at given grid position encoding a certain state.
  def field_at(idx, idy)
    @grid[idy][idx]
  end

  def set_field_at(idx, idy, color)
    field = field_at(idx, idy)
    field.color = color
  end

  def move_shape_one_down
    @shape.move_shape(Point2f.new(0, 1))
  end


  def process_event(message)
    if message == 'd'
      @shape.move_shape(Point2f.new(1,0))
    elsif message == 'a'
      @shape.move_shape(Point2f.new(-1,0))
    elsif message == 's'
      @shape.move_shape(Point2f.new(0, 1))
    elsif message == 'w'
      @shape.rotate
    end
  end

  def to_s
    grid_as_string = ''
    @grid.each do |row|
      row.each do |field|
        grid_as_string += "#{field.to_i} "
      end
      grid_as_string += "\n"
    end
    grid_as_string
  end


end