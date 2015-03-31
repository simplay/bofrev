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
  def self.unlocked
    unlocked_achievements = @instance.achievement_list.select do |_, value|
      value
    end
    unlocked_achievements.map do |key, _|
      [key.to_s]
    end
  end

  def register_achievements
    raise "not implemented yet"
  end

  def handle_event_with(message)
    puts "AAA event received with #{message}"
    if message.type == :score
      handle_score_event(message.content)
    end
  end

  protected

  def handle_score_event(value)
    @achievement_list[:more_than_100p] = true if value > 100
    @achievement_list[:more_than_200p] = true if value > 200
  end



end