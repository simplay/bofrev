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
    filled? ? 1 : 0
  end

end