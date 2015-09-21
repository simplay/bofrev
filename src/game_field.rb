require 'color'
require 'point2f'
require 'drawable'
require 'render_helpers'
require 'java'
require 'game_field_type_constants'

# A GameField is an element of a Grid data structure.
# Each GameField is associated with an index (colum, row) in a parent Grid.
# Every GameField is in a certain state stored in the attribute :type.
# This states defines whether or not a field is fixed on its parent grid or freely movable.
#   see the module GameFieldTypeConstants for further information.
# Lastely, each gamefield has a color assigned. By default it is the color white.
# A gamefield can query its neighbor grid fields (either its  4-or 8-one-neighborhood).
# Each gamefield is therefore an Enumerable over its neighborhood.
class GameField < Drawable

  include Enumerable
  include RenderHelpers
  include GameFieldTypeConstants

  attr_accessor :color, :type, :coordinates, :value,
                :top, :bottom, :left, :right,
                :top_left, :top_right, :bottom_left, :bottom_right

  DEFAULT_COLOR = Color.white
  DEFAULT_TYPE = FREE
  DEFAULT_COORDS = Point2f.new(-1,-1)
  DEFAULT_VALUE = 0

  # @param color [Color] 24bit rgb color.
  # @param type [Symbol] encoding state of field
  #   :free - any non-fixed Field: empty or moving block.
  #   :placed - non-border field that are placed (hit the floor).
  #   :border - special cells that depict the game border. used for collision checks.
  #   :ground_border - the floor border pixel. to check whether we can fall any deeper.
  #     checking for border types would result in index checks
  #     in order to determine whether we are considering a ground border cell
  # @param coordinates [Point2f] index in parent Grid where this GameField is placed.
  #   x corresponds to the row index, y corresponds to the column index in the parent grid.
  # @param value [Integer, Float] value used to perform cellwise grid computations.
  # When drawing onto a canvas, each gamefield defines by itself how it should be drawn onto
  # a given canvas. Drawing is only possible if and only if a gamefield is marked as drawable.
  def initialize(color = DEFAULT_COLOR, type = DEFAULT_TYPE,
                 coordinates=DEFAULT_COORDS, value=DEFAULT_VALUE)
    super(coordinates, true)
    @color = color
    @type = type
    @coordinates = coordinates
    @value = value
  end

  # Draws this GameField onto a given canvas at its coordinates with its assigned color.
  #
  # @hint: GameField is only drawn onto canvas if it is #drawbale?
  #   note that x-coord corresponds to the column idx
  #   note that y-coord corresponds to the row idx
  #
  # @param canvas [Java::JavaAwt::Graphics]
  def draw_onto(canvas)
    if drawable?
      x0 = column_idx*cell_size
      y0 = row_idx*cell_size
      x1 = (column_idx+1)*cell_size
      y1 = (row_idx+1)*cell_size
      draw_rectangle_at(canvas, x0, y0, x1, y1, color)
    end
  end

  # Get the column index of this GameField in its parent grid.
  #
  # @hint: note that we start counting by 0, thus the -1.
  # @return [Integer] column index value.
  def column_idx
    @coordinates.y-1
  end

  # Get the row index of this GameField in its parent grid.
  #
  # @hint: note that we start counting by 0, thus the -1.
  # @return [Integer] row index value.
  def row_idx
    @coordinates.x-1
  end

  # Visit each neighbor of this GameField instance.
  #
  # @param dataset [Symbol] symbolic name of neighborhood
  #   getter that should be used for the each block to iterate over.
  #   by default it is :neighbors_8
  def each(dataset=:neighbors_8, &block)
    if block_given?
      send(dataset).each do |neighbor|
        block.call neighbor
      end
    else
      send(dataset)
    end
  end
  alias_method :each_neighbor, :each

  # Assigns 8-ring neighborhood to this game field.
  # Note that only inner grid fields are inter-connected explicitly.
  #
  # @param neighbors [Hash] containing the 8-ring neighborhood of a cell
  #   :top => [GameField]
  #   :bottom => [GameField]
  #   :left => [GameField]
  #   :right => [GameField]
  #   :top_left => [GameField]
  #   :bottom_left => [GameField]
  #   :bottom_right => [GameField]
  #   :top_right => [GameField]
  def assign_neighborhood(neighbors = {})
    neighbors.each do |key, value|
      send("#{key}=", value)
    end

    left.right = self
    right.left = self
    top.bottom = self
    bottom.top = self

    top_left.bottom_right = self
    top_right.bottom_left = self
    bottom_left.top_right = self
    bottom_right.top_left = self
  end

  # Get whole 4-neighborhood ring of this GameField.
  #
  # @hint: clockwise fetched neighbors, starting at right neighbor.
  # @return [Array] of [GameField] neighbor instances.
  def neighbors
    [@right, @bottom, @left, @top].compact
  end

  # Get whole 8-neighborhood ring of this GameField.
  #
  # @hint: travers neighbors row-wise.
  # @return [Array] of [GameField] neighbor instances.
  def neighbors_8
    [@top_left, @top, @top_right, @left, @right, @bottom_left, @bottom, @bottom_right].compact
  end

  # Sum all values of neighbors.
  #
  # @return [Float] sum of 8-neighborhood ring values.
  def sum_8_neighbor_values
    neighbors_8.inject(0.0) {|sum, field| sum + field.value}
  end

  # does this field have neighbors
  def neighbors?
    neighbors.any? {|neighbor| !neighbor.nil?}
  end

  # Apply *or-wise* a series of checks to this GameField.
  #
  # @hint: The checks refer to ? methods.
  #   in case GameField does not correspond to such a type,
  #   the corresponding check is skipped.
  #
  # @param check_list [Array] of Symbols that are referring to a method name
  #        of GameField that returns a Boolean.
  # @return [Boolean] :true if any of the given checks yields true otherwise :false.
  def fulfills_any?(check_list)
    check_list.any? do |type|
      type = (type.to_s + "?").to_sym unless type.to_s.include?("?")
      send(type) if respond_to?(type)
    end
  end

  # Check if this GameField can be drawn onto a canvas.
  #
  # @hint: a GameField can be drawn onto a canvas if and only if
  #   it is either marked as PLACED, MOVING or is of type BORDER.
  #   GameField instances with a FREE type are not supposed to be drawn.
  # @return [Boolean] true if can be drawn otherwise false.
  def drawable?
    placed? || moving? || border?
  end

  # Is this GameField still moveable?
  #
  # @return [Boolean] true if type is MOVING
  def moving?
    @type == MOVING
  end

  # is this field a free field,
  # i.e. not placed, no border, no ground?
  #
  # @return [Boolean] true if type is FREE
  def free?
    @type == FREE
  end

  # Is this GameField fixed placed in its Grid?
  #
  # @return [Boolean] true if type is PLACED
  def placed?
    @type == PLACED
  end

  # is this field a side-border?
  #
  # @return [Boolean] true if type is BORDER
  def border?
    @type == BORDER
  end

  # is this field a ground border?
  #
  # @return [Boolean] true if type is GROUND_BORDER
  def floor?
    @type == GROUND_BORDER
  end

  # Pretty string representation of a GameField encoding a gamefield's state.
  #
  # @return [String] pretty string representation.
  def to_s
    "t:#{type} c:#{color.to_rgb}"
  end

  # flush current state of this field to default state
  # that is :free and white
  def wipe_out
    @type = DEFAULT_TYPE
    @color = DEFAULT_COLOR
  end

  # TODO: refactor me
  # DO not simply extend type and coordinates
  # will result in a error
  #
  # Copy color and type of another gamefield
  #
  # @param [other] GameField other GameField to be copied.
  def copy_state_from(other)
    @type = other.type
    @color = other.color
  end

  # Some kind of pretty string method for drawing Grid elements (i.e. GameField).
  #
  # @return [Integer] type state integer encoding
  def to_i
    if border?
      2
    elsif floor?
      3
    elsif placed?
      4
    elsif drawable?
      1
    elsif free?
      0
    else
      -1
    end
  end

  private

  # Draw a colored rectangle with having a certain border width onto @canvas.
  #
  # @hint Its top left position is given by a point (x0,y0) and
  # its size by the span between the first and a 2nd point (x1, y1).
  #
  # @param x0 [Integer] or [Float] upper left corner x-component
  # @param y0 [Integer] or [Float] upper left corner y-component
  # @param x1 [Integer] or [Float] lower right corner x-component
  # @param y1 [Integer] or [Float] lower right corner y-component
  # @param color [String] color identifier.
  # @param border_width [Integer] border pixel thickness.
  def draw_rectangle_at(g, x0, y0, x1, y1, color)
    g.setColor(color.to_awt_color)
    g.fillRect(x0, y0, x1-x0, y1-y0)
  end

end
