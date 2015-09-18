require 'achievement_system'
require 'achievement'

class TetrisAchievementSystem < AchievementSystem

  TETRIS_ACHIEVEMENT_LIST = [
      :more_than_100p,
      :more_than_200p
  ]

  def initialize
    super
    @achievements = []
    @achievements << Achievement.new(:more_than_100p, lambda{|value| value > 100})
    @achievements << Achievement.new(:more_than_200p, lambda{|value| value > 200})
    @achievements.each do |achievement|
      register_achievement(achievement.identifier)
    end
  end

  def handle_event_with(message)
    if message.type == :score
      handle_score_event(message.content)
    end
  end

  protected

  def handle_score_event(value)
    @achievements.each do |achievement|
      achievement.check_rule(value)
      update_list_for(achievement.identifier) if achievement.achieved?
    end
  end

end
