class GameField
  attr_accessor :color, :type


  def initialize(color = 'white', type = :field)
    @color = color
    @type = type
  end

  def filled?
    @color != 'white' || border? || floor?
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

  def to_i
    if @type == :border
      2
    elsif @type == :ground_border
      3
    elsif filled?
      1
    else
      0
    end
  end

end