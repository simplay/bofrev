require_relative 'game_field'


class Map

  MAX_HEIGHT = 600 # corresponds to number of rows
  MAX_WIDTH = 240 # corresponds to number of columns

  def initialize
    @grid = []
    MAX_HEIGHT.times do
      row = []
      MAX_WIDTH.times do
        row << GameField.new
      end
      @grid << row
    end

    @shape = Shape.new(self, 'blue')
  end

  # Retrieve a map field at a provided position.
  #
  # @param row [Integer] row index in grid using matrix convention
  # @param column [Integer] column index in grid using matrix convention
  # @return [GameField] field at given grid position encoding a certain state.
  def field_at(row, column)
    @grid[row][column]
  end

  def set_field_at(row, column, color)
    field = field_at(row, column)
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




end