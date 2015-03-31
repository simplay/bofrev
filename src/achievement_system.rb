require_relative 'observer'

class AchievementSystem < Observer


  def self.instance
    if @instance.nil?
      @instance = AchievementSystem.new
    end
    @instance
  end

  def initialize
    @achievement_list = {
        :more_than_100p => false,
        :more_than_200p => false
    }
  end

  def achievement_list
    @achievement_list
  end

  # retrieve all currently unlocked achievements as a list of string of their identifier.
  def self.all_unlocks
    unlocked_achievements = @instance.achievement_list.select do |_, value|
      value
    end
    unlocked_achievements.map do |key, _|
      [key.to_s]
    end
  end

  def self.last_unlock
    @instance.last_unlock
  end

  def last_unlock
    @last_unlock.nil? ? '' : @last_unlock.to_s
  end

  def register_achievement(identifier)
    @achievement_list[identifier] = false
  end

  def handle_event_with(message)
    if message.type == :score
      handle_score_event(message.content)
    end
  end

  protected

  def update_list_for(key)
    @achievement_list[key] = true
    @last_unlock = key
  end

  def handle_score_event(value)
    if value > 200
      update_list_for(:more_than_200p)
    elsif value > 100
      update_list_for(:more_than_100p)
    end
  end

end