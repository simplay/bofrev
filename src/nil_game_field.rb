class NilGameField

  def initialize(color = 'white', type = :field)
    @color = color; @type = type
    @is_sentinel = true
  end

end