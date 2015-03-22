class GameField
  attr_accessor :color


  def initialize(color = 'white')
    @color = color
  end

  def filled?
    @color != 'white'
  end

  def to_s
    "#{color}"
  end

  def to_i
    if color == 'black'
      2
    elsif filled?
      1
    else
      0
    end
  end

end