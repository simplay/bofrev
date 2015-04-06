class Snake
  attr_accessor :positions
  attr_reader :segments

  def initialize(position, delta)
    @positions = [position]
    @movements = [delta]
    @saved_new_pos = []
  end

  def move
    @movements.each_with_index do |segment, idx|
      @positions[idx].add(segment)
    end
  end

  def append_movement(delta)
    @movements << delta
  end

  def update_movement(delta)
    @movements.reverse!
    @movements.pop
    @movements.reverse!
    @movements << delta
  end

  def append_position(position)
    @saved_new_pos << position
  end

  def cleanup_positions
    @positions.reverse!
    @saved_new_pos.each do |pos|
      @positions << pos
    end
    @positions.reverse!
    @saved_new_pos = []
  end

  def head
    @positions.last
  end

  def tail
    @positions.first
  end

  def to_s
    "p: #{@positions.map &:to_s}\ns: #{@movements.map &:to_s}"
  end



end