require 'game_field'
require 'point2f'
require 'drawables/drawable'
require 'drawables/grid_box'

require 'color' if (RUBY_PLATFORM != "java")

# Grid is the Data Structure for an arbitrary 2d-(M x N) pixel game.
# A grid has actually (M+2)x(N+2) pixels. There is an border around the grid.
#
# Benefits:
#   + That can be used to perform intersection tests.
#     e.g. if hit border pixel, then we detected a collision.
#
#   + Allows to define Gui-pixel resolution independent from number of game cells.
#
# Internal representation is encoded initially as the following:
#
#   B B .. B B
#   B 0 .. 0 B
#   .        .
#   .        .
#   B 0 .. 0 B
#   B B .. B B
#
# where B depicts a border cell,
class Grid < Drawable

  include Enumerable

  # Build a new Grid of Dimension (width x height)
  #
  # @example: Grid.new(8,5).to_s
  #   #=>
  #     2 2 2 2 2 2 2 2 2 2
  #     2 0 0 0 0 0 0 0 0 2
  #     2 0 0 0 0 0 0 0 0 2
  #     2 0 0 0 0 0 0 0 0 2
  #     2 0 0 0 0 0 0 0 0 2
  #     2 0 0 0 0 0 0 0 0 2
  #     2 3 3 3 3 3 3 3 3 2
  #
  # @param width [Integer] width of grid
  # @param height [Integer] height of grid
  def initialize(width, height, show_grid=false)
    super(Point2f.new, true)
    # assign dimensions
    @inner_width = width
    @inner_height = height

    # Internal data-structure of a the grid.
    @data = build_empty_grid

    specify_borders
    encode_grid_neighborhood

    @grid_box = GridBox.new
    @grid_is_shown = show_grid
  end

  # Overwrites our game fields with those from other grid.
  #
  # @param other_grid [Grid] other grid we want to use for copying.
  def overwrite_us_with(other_grid)
    inner_height_iter.each do |row_idx|
      other_grid.inner_row_at(row_idx).each_with_index do |other_field, idx|
        set_field_value_at(idx+1, row_idx, other_field.value)
        set_field_color_at(idx+1, row_idx, other_field.color)
      end
    end
    nil
  end

  def each(&block)
    inner_height_iter.each do |row_idx|
      inner_row_at(row_idx).each_with_index do |other_field, idx|
        field = field_at(idx+1, row_idx)
        if block_given?
          block.call field
        else
          yield field
        end
      end
    end
  end

  # Draw this shape onto a given canvas.
  def draw_onto(canvas)
    each do |field|
      field.draw_onto(canvas)
    end
    @grid_box.draw_onto(canvas) if @grid_is_shown
  end

  # Get total width of grid that is the 2 Border pixels
  # plus M from the grid kernel (sides).
  #
  # @return [Integer] total width of grid - kernel + border
  def total_width
    @inner_width + 2
  end

  # Get total height of grid that is the 2 Border pixels
  # plus N from the grid kernel (floor & ceil).
  #
  # @return [Integer] total height of grid
  def total_height
    @inner_height + 2
  end

  # Grid height without border (top and bottom border).
  #
  # @hint: corresponds to Grid#total_height - 2
  # @return [Integer] inner height of grid.
  def inner_height
    @inner_height
  end

  # Grid width without border (left and right border).
  #
  # @hint: corresponds to Grid#total_width - 2
  # @return [Integer] inner width of grid.
  def inner_width
    @inner_width
  end

  # Height cell Range of grid's inner cells
  # (i.e. grid without border cells).
  # @return [Range] of inner height indices in grid.
  def inner_height_iter
    (1..@inner_height)
  end

  # Width cell Range of grid's inner cells
  # (i.e. grid without border cells).
  # @return [Range] of inner width indices in grid.
  def inner_width_iter
    (1..@inner_width)
  end

  # Get row at given index.
  # @param idx [Integer] row index
  # @hint starts counting at 0 and ends at @grid.size-1
  def row_at(idx)
    @data[idx]
  end

  # Get row :idx at given index excluding its border cells.
  #   @param idx [Integer] row index
  #   @hint starts counting at 1 and ends at @grid.size-2
  def inner_row_at(idx)
    row_at(idx)[1..-2]
  end

  # Get game field at position (x,y) in MxN grid.
  #
  # @param x [Integer] row index
  # @param y [Integer] column index
  # @return [GameField] at given (x,y) location.
  def field_at(x, y)
    # NB: lookup is inverted, since array is build internally this way:
    # see Grid#build_empty_grid
    @data[y][x]
  end

  # Assign a new game field :field at a given location (x,y) in the grid.
  #
  # @param x [Integer] row index
  # @param y [Integer] column index
  # @param field [GameField] game field used for update
  def set_field_at(x, y, field)
    @data[y][x] = field
  end

  # Update a whole inner row bz an array of game fields.
  # Assumption: Dimensionality of given field array matches inner row length
  # and the order of the elements in the array corresponds to the row.
  #
  # @param row_idx inner row index
  # @param fields [Array] of GameField instances we use
  # for updating the target row.
  def set_inner_row_at(row_idx, fields)
    fields.each_with_index do |field, col_idx|
      set_field_at(col_idx+1, row_idx, field)
    end
  end

  # Assign a new game color at a given field location (x,y) in the grid.
  #
  # @param x [Integer] row index
  # @param y [Integer] column index
  # @param color [String] game field color
  def set_field_color_at(x, y, color)
    @data[y][x].color = color
  end

  # Assign a new game color at a given field location (x,y) in the grid.
  #
  # @param x [Integer] row index
  # @param y [Integer] column index
  # @param value [Integer] game field value
  def set_field_value_at(x, y, value)
    @data[y][x].value = value
  end

  def flush_field_at(x, y)
    field_at(x,y).wipe_out
  end

  # @return [String] Matrix form of grid encoded as string.
  def to_s
    grid_as_string = ''
    @data.each do |row|
      row.each do |field|
        grid_as_string += "#{field.to_i} "
      end
      grid_as_string += "\n"
    end
    grid_as_string
  end

  protected

  # Create an empty game grid cells
  #
  # @hint: (1..4).map do (1..2).map do 1 end end
  #   #=> [[1, 1], [1, 1], [1, 1], [1, 1]]
  #
  # @return [Array[Array]] an array of arrays encoding the game grid.
  def build_empty_grid
    @data = (1..total_height).map do |idx|
      (1..total_width).map do |idy|
        GameField.new(Color.white, :field, Point2f.new(idx-1, idy-1))
      end
    end
  end

  # Mark Grid Borders as special pixels
  def specify_borders
    # setup y border
    total_width.times do |idy|
      set_field_at(idy, 0, GameField.new(Color.black, :border))
      set_field_at(idy, total_height-1, GameField.new(Color.black, :ground_border))
    end

    # setup x border
    total_height.times do |idx|
      set_field_at(0, idx, GameField.new(Color.black, :border))
      set_field_at(total_width-1, idx, GameField.new(Color.black, :border))
    end
  end

  # Encode 4-Neighborhood information to every game field (except borders).
  def encode_grid_neighborhood

    # only iterate over kernel: we do not care about border cells
    inner_height_iter.each do |idy|
      inner_width_iter.each do |idx|
        cell = field_at(idx, idy)
        neighbors = {
            :right => field_at(idx+1, idy), :left => field_at(idx-1, idy),
            :bottom => field_at(idx, idy+1), :top => field_at(idx, idy-1),
            :top_left => field_at(idx-1, idy-1), :top_right => field_at(idx+1, idy-1),
            :bottom_left => field_at(idx-1, idy+1), :bottom_right => field_at(idx+1, idy+1)
        }
        cell.assign_neighborhood(neighbors)
      end
    end
  end

end
