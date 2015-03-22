class Map


  def initialize
    @grid = []
    10.times do
      row = []
      10.times do
        row << "."
      end
      @grid << row
    end

  end

  # @param row [Integer] row index in grid using matrix convention
  # @param row [Integer] column index in grid using matrix convention
  # @return [String] state at given grid position
  def state_at(row, column)
    @grid[row][column]
  end

end