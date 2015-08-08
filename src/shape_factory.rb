require 'point2f'

# Will build prespecified shaped (stored in files)
class ShapeFactory
  SIZE = 50

  def initialize(type)

  end

  def build
    points = []
    SIZE.times do |idx|
      SIZE.times do |idy|
        points << Point2f.new(idx, idy)
      end
    end
    points
  end
end
