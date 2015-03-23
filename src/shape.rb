require_relative 'point2f'
require_relative 'collision_checker'
require 'thread'
class Shape
  attr_accessor :local_points, :origin # origin of local coordinate system, this changes during updates.
  attr_reader :color # binary shape of figure, remains constant AND color
  attr_accessor :grid_map
  def initialize(map, color)
    @origin = Point2f.new(5, 0)

    @position_states = [
        [Point2f.new(-1,0), Point2f.new(0,0), Point2f.new(1,0)],
        [Point2f.new(0,-1), Point2f.new(0,0), Point2f.new(0,1)],
        [Point2f.new(-1,0), Point2f.new(0,0), Point2f.new(1,0)],
        [Point2f.new(0,-1), Point2f.new(0,0), Point2f.new(0,1)]
    ]

    @rotation_modus = 0
    @local_points = @position_states[@rotation_modus]

    @grid_map = map
    @color = color
    @mutex = Mutex.new

    map_positions.each do |p|
      @grid_map.set_field_at(p.x, p.y, color)
    end

  end

  def next_rotation_position
    @position_states[(@rotation_modus+1)%4]
  end

  def next_moved_origin(shift)
    Point2f.new(1,1).add(@origin).add(shift)
  end

  def rotate
    unless CollisionChecker.new(self, :rotate).blocked?
      @mutex.synchronize do

        map_positions.each do |p|
          @grid_map.set_field_at(p.x, p.y, 'white')
        end

        @rotation_modus = (@rotation_modus + 1) % 4
        @local_points = @position_states[@rotation_modus]

        map_positions.each do |p|
          @grid_map.set_field_at(p.x, p.y, @color)
        end
      end
    end
  end

  # TODO: make collision check
  # @param move_by [Point2f] relative movement in plane.
  def move_shape(move_by=Point2f.new(0,0))

    collision_state = CollisionChecker.new(self, :move, move_by)

    if !collision_state.blocked?
      @mutex.synchronize do

        map_positions.each do |p|
          @grid_map.set_field_at(p.x, p.y, 'white')
        end

        update_position_by(move_by)

        map_positions.each do |p|
          @grid_map.set_field_at(p.x, p.y, @color)
        end
      end
    elsif collision_state.state == :grounded
      puts "new shape created"
      @grid_map.spawn_new_shape
    end
  end

  def to_s
    (@local_points.map &:to_s).join(" ")
  end

  def points_in_grid_coords
    @local_points.map do |point|
      Point2f.new(point.x + @origin.x + 1, point.y + @origin.y + 1)
    end
  end

  def mark_fields_placed
    points_in_grid_coords.each do |p|
      @grid_map.field_at(p.x, p.y).type = :placed
    end

    @grid_map.check_for_combo

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
      Point2f.new(base.x + cell.x + shift_by.x + 1, base.y + cell.y + shift_by.x + 1)
    end
  end

end