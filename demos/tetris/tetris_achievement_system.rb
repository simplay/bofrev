require 'achievement_system'

class TetrisAchievementSystem < AchievementSystem

  TETRIS_ACHIEVEMENT_LIST = [
      :more_than_100p,
      :more_than_200p
  ]

  def initialize
    super
    TETRIS_ACHIEVEMENT_LIST.each do |achievement|
      register_achievement(achievement)
    end
  end

  def handle_event_with(message)
    if message.type == :score
      handle_score_event(message.content)
    end
  end

  protected

  def handle_score_event(value)
    if value > 200
      update_list_for(:more_than_200p)
    elsif value > 100
      update_list_for(:more_than_100p)
    end
  end

end
