class Score

  def initialize
    @score = 0
  end

  def increment_by(score_value)
    @score += score_value
  end

  def final_points
    @score
  end
end