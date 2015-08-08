require 'observable'
require 'event'
require 'game_settings'

class Score
 include Observable

  def initialize
    @score = 0
    subscribe(GameSettings.achievement_system)
  end

  def increment_by(score_value)
    @score += score_value
    notify_all_targets_of_type_with_message(GameSettings.achievement_system_sym, Event.new(:score, @score))
  end

  def final_points
    notify_all_targets_of_type_with_message(GameSettings.achievement_system_sym, Event.new(:score, @score))
    @score
  end
end
