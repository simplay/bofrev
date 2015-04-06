class Point2f
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x; @y = y
  end

  def copy
    Point2f.new(@x, @y)
  end

  # @param other [Point2f]
  def add(other)
    @x = @x + other.x
    @y = @y + other.y
    self
  end

  def scale_by(factor)
    @x *= factor; @y *= factor
    self
  end

  def to_s
    "p=(#{@x} #{@y})"
  end

  def ==(other)
    other.x  == @x && other.y == @y
  end
end