require 'color'
require 'point2f'
require 'drawables/drawable'
require 'render_helpers'
require 'java'

class GameField < Drawable

  include Enumerable
  include RenderHelpers

  attr_accessor :color, :type, :coordinates, :value,
                :top, :bottom, :left, :right,
                :top_left, :top_right, :bottom_left, :bottom_right

  TYPES = [
    :free,
    :placed,
    :border,
    :ground_border
  ]

  # @param color [Color] 32bit rgb colour.
  # @param type [Symbol] incoding state of field
  #   :free - any non-fixed Field: empty or moving block.
  #   :placed - non-border field that are placed (hit the floor).
  #   :border - special cells that depict the game border. used for collision checks.
  #   :ground_border - the floor border pixel. to check whether we can fall any deeper.
  #     checking for border types would result in index checks
  #     in order to determine whether we are considering a ground border cell
  def initialize(color = Color.white, type = :free, coordinates=Point2f.new(-1,-1), value=0)
    super(coordinates, true)
    @color = color
    @type = type
    @coordinates = coordinates
    @value = value
  end

  # note that x-coord corresponds to the column idx
  # note that y-coord corresponds to the row idx
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

  def column_idx
    @coordinates.y-1
  end

  def row_idx
    @coordinates.x-1
  end

  # remove when drawing logic has been exported to this class
  def color_value
    @color.to_rgb
  end

  def clone
    GameField.new(@color, @type, @coordinates, @value)
  end

  def each(dataset=:neighbors_8, &block)
    send(dataset).each do |neighbor|
      if block_given?
        block.call neighbor
      else
        yield neighbor
      end
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

  # get whole 4-neighborhood ring of this pixel
  # @hint: clockwise fetched neighbors, starting at right neighbor.
  # @return [Array] of [GameField] neighbor instances.
  def neighbors
    [@right, @bottom, @left, @top].compact
  end

  # get whole 8-neighborhood ring of this pixel
  # @return [Array] of [GameField] neighbor instances.
  def neighbors_8
    [@top_left, @top, @top_right, @left, @right, @bottom_left, @bottom, @bottom_right].compact
  end

  def sum_8_neighbor_values
    neighbors_8.inject(0.0) do |sum, field| sum + field.value end
  end

  # does this field have neighbors
  def neighbors?
    neighbors.any? {|neighbor| !neighbor.nil?}
  end

  # Apply *or-wise* a series of checks to this GameField.
  #
  # @param check_list [Array] of Symbols that are referring to a method name
  #        of GameField that returns a Boolean.
  # @return [Boolean] :true if any of the given checks yields true otherwise :false.
  def fulfills_any?(check_list)
    check_list.any? do |type|
      send(type)
    end
  end

  # can data of this cell be used when redrawing the canvas?
  def drawable?
    @color != Color.white && @color != Color.black
  end

  # is this field a free field,
  # i.e. not placed, no border, no ground?
  def free?
    @type == :free
  end

  # this this field placed by a block?
  def placed?
    @type == :placed
  end

  # is this field a side-border?
  def border?
    @type == :border
  end

  # is this field a ground border?
  def floor?
    @type == :ground_border
  end

  def to_s
    "#{color.to_rgb}"
  end

  # flush current state of this field to default state
  # that is :free and white
  def wipe_out
    @type = :free
    @color = Color.white
  end

  def copy_state_from(other)
    @type = other.type
    @color = other.color
  end

  def to_i
    if @type == :border
      2
    elsif @type == :ground_border
      3
    elsif @type == :placed
      4
    elsif drawable?
      1
    else
      0
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
