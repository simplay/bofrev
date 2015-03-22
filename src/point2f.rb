class Point2f
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x; @y = y
  end

  # @param other [Point2f]
  def add(other)
    @x = @x + other.x
    @y = @y + other.y
    self
  end

  def to_s
    "p=(#{@x} #{@y})"
  end
end