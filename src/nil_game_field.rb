require_relative 'game_field'

class NilGameField < GameField

  def self.instance
    if @instance.nil?
      @instance = NilGameField.new
    end
    @instance
  end

  def initialize(color = 'white', type = :field)
    @is_sentinel = true
    super(color, type)
  end

end