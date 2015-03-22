require_relative 'point2f'
require 'thread'
class Shape
  attr_accessor :origin # origin of local coordinate system, this changes during updates.
  attr_reader :local_points, :color # binary shape of figure, remains constant AND color

  def initialize(map, color)
    @origin = Point2f.new(0,0)
    @local_points = [Point2f.new(0,0), Point2f.new(1,0), Point2f.new(2,0)]

    @map = map
    @color = color
    @mutex = Mutex.new

    map_positions.each do |p|
      @map.set_field_at(p.x, p.y, color)
    end

  end

  # TODO: make collision check
  # @param move_by [Point2f] relative movement in plane.
  def move_shape(move_by)
    @mutex.synchronize do

      map_positions.each do |p|
        @map.set_field_at(p.x, p.y, 'white')
      end

      update_position_by(move_by)

      map_positions.each do |p|
        @map.set_field_at(p.x, p.y, @color)
      end
    end

  end


  def to_s
    (@local_points.map &:to_s).join(" ")
  end

  private

  # position of this shape in map coordinate system
  def map_positions
    shifted_position(@origin)
  end

  # updates local postions of this shape
  def update_position_by(shift)
    puts "before #{@origin} class: #{@origin.class.to_s}"
    @origin = @origin.add(shift)
    puts "after #{@origin} class: #{@origin.class.to_s}"
  end

  def shifted_position(base, shift_by=Point2f.new(0,0))
    @local_points.map do |cell|
      Point2f.new(base.x + cell.x + shift_by.x, base.y + cell.y + shift_by.x)
    end
  end

end