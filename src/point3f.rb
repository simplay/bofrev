# a three dimensional Point. By default has value (0,0,0).
# For instance, this can be used to represent RGB color values.
class Point3f
  attr_accessor :x, :y, :z

  # Create a new Point3f instance.
  #
  # @hint default values: (x,y,z) = (0,0,0)
  # @param x [Float] or [Integer] component
  # @param y [Float] or [Integer] component
  # @param z [Float] or [Integer] component
  def initialize(x=0, y=0, z=0)
    @x = x
    @y = y
    @z = z
  end

  # Get a exact value copy of this Point3f
  # @return [Point3f] copy of this instance.
  def copy
    Point3f.new(@x, @y, @z)
  end

  # Add other Point3f to this.
  #
  # @hint Old (x,y,z) values get overwridden.
  # @param other [Point3f]
  # @return [Point3f] self
  def add(other)
    @x = @x + other.x
    @y = @y + other.y
    @z = @z + other.z
    self
  end

  # Subtract other Point3f from this.
  #
  # @hint Old (x,y,z) values get overwridden.
  # @param other [Point3f]
  # @return [Point3f] self
  def sub(other)
    @x = @x - other.x
    @y = @y - other.y
    @z = @z - other.z
    self
  end

  # Scale this Point3f by a given factor.
  #
  # @hint Old (x,y,z) values get overwridden.
  # @param factor [Float]
  # @return [Point3f] self
  def scale_by(factor)
    @x *= factor
    @y *= factor
    @z *= factor
    self
  end

  # Pretty string representation of this instance.
  #
  # @return [String]
  def to_s
    "p=(#{@x}, #{@y}, #{@z})"
  end

  # Checks whether components of other Point3f have the same value as this Point3f instance.
  #
  # @param other [Point3f]
  # @return [Boolean] true if components are the same and false otherwise.
  def ==(other)
    other.x == @x && other.y == @y && other.z == @z
  end

end
