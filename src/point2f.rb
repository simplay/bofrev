# a two dimensional Point. By default has value (0,0).
class Point2f
  attr_accessor :x, :y

  # Create a new Point2f instance.
  #
  # @hint default values: (x,y) = (0,0)
  # @param x [Float] or [Integer] component
  # @param y [Float] or [Integer] component
  def initialize(x=0, y=0)
    @x = x; @y = y
  end

  # Get a exact value copy of this Point2f
  # @return [Point2f] copy of this instance.
  def copy
    Point2f.new(@x, @y)
  end

  # Add other Point2f to this.
  #
  # @hint Old (x,y) values get overwridden.
  # @param other [Point2f]
  # @return [Point2f] self
  def add(other)
    @x = @x + other.x
    @y = @y + other.y
    self
  end

  # Subtract other Point2f from this.
  #
  # @hint Old (x,y) values get overwridden.
  # @param other [Point2f]
  # @return [Point2f] self
  def sub(other)
    @x = @x - other.x
    @y = @y - other.y
    self
  end

  # Scale this Point2f by a given factor.
  #
  # @hint Old (x,y) values get overwridden.
  # @param factor [Float]
  # @return [Point2f] self
  def scale_by(factor)
    @x *= factor; @y *= factor
    self
  end

  # Pretty string representation of this instance.
  #
  # @return [String]
  def to_s
    "p=(#{@x} #{@y})"
  end

  # Get a 2d vector pointing from other to this
  #
  # @param other [Point2f] 2d point we want to compare with.
  # @return [Point2f] vector pointing from given other point to this point.
  def direction_to(other)
    copy.sub(other)
  end

  # Get distance between this and #other vector.
  #
  # @param other [Point2f] 2d point we want to compare with.
  # @return [Float] l2 distance between this and another vector.
  def distance_to(other)
    direction_to(other).length
  end

  # Euclidian length of this vector.
  #
  # @return [Float] l2 norm
  def length
    Math.sqrt(@x**2 + @y**2)
  end

  # Checks whether components of other Point2f have the same value as this Point2f instance.
  #
  # @param other [Point2f]
  # @return [Boolean] true if components are the same and false otherwise.
  def ==(other)
    other.x == @x && other.y == @y
  end

end
