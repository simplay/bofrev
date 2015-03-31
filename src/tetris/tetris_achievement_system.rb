require_relative '../../src/achievement_system'

class TetrisAchievementSystem < AchievementSystem

  def initialize
    super

  end

  def handle_event_with(message)
    if message.type == :score
      handle_score_event(message.content)
    end
  end

  def self.itself
    TetrisAchievementSystem
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