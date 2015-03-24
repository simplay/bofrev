require_relative 'game_field'

class NilGameField < GameField

  def initialize(color = 'white', type = :field)
    super(color, type)
    @is_sentinel = true
  end
end