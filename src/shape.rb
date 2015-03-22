require_relative 'point2f'
class Shape
  attr_accessor :origin # origin of local coordinate system, this changes during updates.
  attr_reader :local_points # binary shape of figure, remains constant.

  def initialize
    @origin = Point2f.new(0,0)
    @local_points = [Point2f.new(0,0), Point2f.new(1,0), Point2f.new(2,0)]
  end

  def map_positions
    shifted_mask(@origin)
  end

  def update_position_by(shift)
    puts "before #{@origin} class: #{@origin.class.to_s}"
    @origin = @origin.add(shift)
    puts "after #{@origin} class: #{@origin.class.to_s}"
  end

  def to_s
    (@local_points.map &:to_s).join(" ")
  end

  private

  def shifted_mask(base, shift_by=Point2f.new(0,0))
    @local_points.map do |cell|
      Point2f.new(base.x + cell.x + shift_by.x, base.y + cell.y + shift_by.x)
    end
  end

end