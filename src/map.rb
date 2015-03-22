require_relative 'game_field'
require 'thread'

class Map

  MAX_HEIGHT = 600 # corresponds to number of rows
  MAX_WIDTH = 240 # corresponds to number of columns

  def initialize

    @mutex = Mutex.new
    @grid = []
    MAX_HEIGHT.times do
      row = []
      MAX_WIDTH.times do
        row << GameField.new
      end
      @grid << row
    end

    @shape = Shape.new

    @shape.map_positions.each do |p|
      set_field_at(p.x, p.y, 'red')
    end

    puts @grid[0][0]

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


  def process_event(message)
    if message == 'd'
      move_shape(Point2f.new(1,0))
    elsif message == 'a'
      move_shape(Point2f.new(-1,0))
    elsif message == 'd'
      move_shape(Point2f.new(0, 1))
    end
  end


  # @param move_by [Point2f] relative movement in plane.
  def move_shape(move_by)
    @mutex.synchronize do
      # TODO: make collision check, let shap handle itself
      @shape.map_positions.each do |p|
        set_field_at(p.x, p.y, 'white')
      end

      @shape.update_position_by(move_by)

      @shape.map_positions.each do |p|
        set_field_at(p.x, p.y, 'red')
      end
    end
    
  end

end