require_relative 'observable'
require_relative 'achievement_system'
require_relative 'event'

class Score
 include Observable

  def initialize
    @score = 0
    subscribe(AchievementSystem.instance)
  end

  def increment_by(score_value)
    @score += score_value
    notify_all_targets_of_type_with_message(:achievement_system, Event.new(:score, @score))
  end

  def final_points
    notify_all_targets_of_type_with_message(:achievement_system, Event.new(:score, @score))
    @score
  end
end