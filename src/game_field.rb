class GameField
  attr_accessor :color, :type,
                :top, :bottom, :left, :right

  # @param color [String] color name supported by [Tk]
  # @param type [Symbol] incoding state of field
  #   :field - any non-fixed Field: empty or moving block.
  #   :placed - non-border field that are placed (hit the floor).
  #   :border - special cells that depict the game border. used for collision checks.
  #   :ground_border - the floor border pixel. to check whether we can fall any deeper.
  #     checking for border types would result in index checks
  #     in order to determine whether we are considering a ground border cell
  def initialize(color = 'white', type = :field)
    @color = color
    @type = type
  end

  # @param neighbors [Hash] containing the 4-ring neighborhood of a cell
  #   :top => [GameField]
  #   :bottom => [GameField]
  #   :left => [GameField]
  #   :right => [GameField]
  def assign_neighborhood(neighbors = {})
    neighbors.each do |key, value|
      send("#{key}=", value)
    end

    left.right = self
    right.left = self
    top.bottom = self
    bottom.top = self

  end

  # get whole 4-neighborhood ring of this pixel
  # @hint: clockwise fetched neighbors, starting at right neighbor.
  # @return [Array] of [GameField] neighbor instances.
  def neighbors
    [@right, @bottom, @left, @top].compact
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
    @color != 'white' && @color != 'black'
  end

  # is this field a free field,
  # i.e. not placed, no border, no ground?
  def free?
    @type == :field
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
    "#{color}"
  end

  # flush current state of this field to default state
  # that is :field (empty) and white
  def wipe_out
    @type = :field
    @color = 'white'
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

end