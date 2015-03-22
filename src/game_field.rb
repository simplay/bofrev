class GameField
  attr_accessor :state, :color

  EMPTY = :empty
  FILLED = :filled

  def initialize(color = 'red')
    @state = EMPTY
    @color = color
  end

  def filled?
    @state == FILLED
  end

end