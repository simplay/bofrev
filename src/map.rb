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

  end

  # Retrieve a map field at a provided position.
  #
  # @param row [Integer] row index in grid using matrix convention
  # @param column [Integer] column index in grid using matrix convention
  # @return [GameField] field at given grid position encoding a certain state.
  def field_at(row, column)
    @grid[row][column]
  end

end