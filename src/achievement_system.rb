require_relative 'observer'

class AchievementSystem < Observer

  attr_accessor :achievement_list

  def self.instance
    if @instance.nil?
      @instance = itself.new
    end
    @instance
  end

  def initialize
    @achievement_list = {}
  end

  # should return Achievement class
  def self.itself
    raise 'not implemented yet'
  end

  def achievement_list
    @achievement_list
  end

  # retrieve all currently unlocked achievements as a list of string of their identifier.
  def all_unlocks
    unlocked_achievements = achievement_list.select do |_, value|
      value
    end
    unlocked_achievements.map do |key, _|
      [key.to_s]
    end
  end

  def self.last_unlock
    instance.last_unlock
  end

  def last_unlock
    @last_unlock.nil? ? '' : @last_unlock.to_s
  end

  def register_achievement(identifier)
    @achievement_list[identifier] = false
  end

  def handle_event_with(message)
    raise 'not implemented yet'
  end

  protected

  def update_list_for(key)
    @achievement_list[key] = true
    @last_unlock = key
  end

end