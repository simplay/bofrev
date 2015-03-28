require_relative '../shape'
class TBlock < Shape
  def initialize(map, color)
    super(map, color)
  end

  def position_states
    [
        [Point2f.new(-1,1), Point2f.new(0,1), Point2f.new(1,1), Point2f.new(0,0)],
        [Point2f.new(-1,1), Point2f.new(-1,0), Point2f.new(-1,-1), Point2f.new(0,0)],
        [Point2f.new(-1,-1), Point2f.new(0,-1), Point2f.new(1,-1), Point2f.new(0,0)],
        [Point2f.new(1,1), Point2f.new(1,0), Point2f.new(1,-1), Point2f.new(0,0)]
    ]
  end
end