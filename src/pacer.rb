require_relative 'settings'

# Defines an adaptive tick rate of the game
# increasing with a player's points.
class Pacer

  include Settings

  # @param score [Score] game score used for updating the tick rate.
  def initialize(score)
    @score = score
    @current_speed = TICKS_PER_SECOND
    @previous_points = 0
  end

  # Return current ticks per second rate.s
  # Every 60 additional points update update ticks per second rate
  # @return [Integer] ticks per second.
  def ticks_per_second
    if (@score.final_points-@previous_points > 50)
      @current_speed += 1
      @previous_points = @score.final_points
    end
    @current_speed
  end

end