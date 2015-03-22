class GameField
  attr_accessor :color


  def initialize(color = 'white')
    @color = color
  end

  def filled?
    @color != 'white'
  end

end