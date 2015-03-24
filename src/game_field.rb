require_relative 'nil_game_field'
class GameField
  attr_accessor :color, :type,
                :top, :bottom, :left, :right,
                :is_sentinel

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
    @is_sentinel = false

    # sentinel = NilGameField.new(color, type)
    # assign_neighborhood({
    #     :right => sentinel, :left => sentinel,
    #     :bottom => sentinel, :top => sentinel
    # })

  end

  # @param neighbors [Hash] containing the 4-ring neighborhood of a cell
  #   :top => [GameField]
  #   :bottom => [GameField]
  #   :left => [GameField]
  #   :right => [GameField]
  def assign_neighborhood(neighbors = {})
    neighbors.each do |key, value|
      send("#{key}=","#{value}")
    end
  end

  def empty?
    !filled?
  end

  def bottom_successor?
    not_nil = @bottom != nil
    if not_nil
      return !@bottom.border?
    end
    false
  end

  # get whole 4-neighborhood ring of this pixel
  # @hint: clockwise fetched neighbors, starting at right neighbor.
  # @return [Array] of [GameField] neighbor instances.
  def neighbors
    [right, bottom, left, top]
  end

  # does this field have neighbors
  def neighbors?
    neighbors.any? {|neighbor| !neighbor.nil?}
  end

  def filled?
    @color != 'white' && @color != 'black'
  end

  def placed?
    @type == :placed
  end

  def border?
    @type == :border
  end

  def floor?
    @type == :ground_border
  end

  def to_s
    "#{color}"
  end

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
    elsif filled?
      1
    else
      0
    end
  end

end