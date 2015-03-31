require_relative 'observable'
require_relative 'event'
require_relative 'settings'

class Score
 include Observable
 include Settings

  def initialize
    @score = 0
    subscribe(Settings.achievement_system)
  end

  def increment_by(score_value)
    @score += score_value
    notify_all_targets_of_type_with_message(Settings.achievement_system_sym, Event.new(:score, @score))
  end

  def final_points
    notify_all_targets_of_type_with_message(Settings.achievement_system_sym, Event.new(:score, @score))
    @score
  end
end