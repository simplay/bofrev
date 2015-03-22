require_relative 'point2f'
require_relative 'collision_checker'
require 'thread'
class Shape
  attr_accessor :origin # origin of local coordinate system, this changes during updates.
  attr_reader :local_points, :color # binary shape of figure, remains constant AND color

  def initialize(map, color)
    @origin = Point2f.new(5,0)

    @position_states = [
        [Point2f.new(-1,0), Point2f.new(0,0), Point2f.new(1,0)],
        [Point2f.new(0,-1), Point2f.new(0,0), Point2f.new(0,1)],
        [Point2f.new(-1,0), Point2f.new(0,0), Point2f.new(1,0)],
        [Point2f.new(0,-1), Point2f.new(0,0), Point2f.new(0,1)]
    ]

    @rotation_modus = 0
    @local_points = @position_states[@rotation_modus]

    @map = map
    @color = color
    @mutex = Mutex.new

    map_positions.each do |p|
      @map.set_field_at(p.x, p.y, color)
    end

  end

  def rotate
    unless CollisionChecker.new(self, @map, :rotate).blocked?
      @mutex.synchronize do

        puts map_positions.to_s

        map_positions.each do |p|
          @map.set_field_at(p.x, p.y, 'white')
        end

        @rotation_modus = (@rotation_modus + 1) % 4
        @local_points = @position_states[@rotation_modus]

        map_positions.each do |p|
          @map.set_field_at(p.x, p.y, @color)
        end
      end
    end
  end

  # TODO: make collision check
  # @param move_by [Point2f] relative movement in plane.
  def move_shape(move_by=Point2f.new(0,0))
    unless CollisionChecker.new(self, @map, :move, move_by).blocked?
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
    @origin = @origin.add(shift)
  end

  def shifted_position(base, shift_by=Point2f.new(0,0))
    @local_points.map do |cell|
      Point2f.new(base.x + cell.x + shift_by.x, base.y + cell.y + shift_by.x)
    end
  end

end