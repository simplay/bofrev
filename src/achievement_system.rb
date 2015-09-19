require 'observer'

# An AchievementSystem models a container that stores a set of Achievement instances.
# It is also responsible for keeping track which achievements were achieved, which one was
# the last unlocked achievement. An achievement observer other Objects (e.g Score instances).
# And get notified whenever their observed instance notifies them. usually, then the checks,
# whether a particular achievement got fulfilled or not, are performed then.
class AchievementSystem < Observer

  attr_accessor :achievement_list

  # Obtain the singleton of this class
  #
  # @return [AClass < AchievementSystem] singleton that inherits from AchievementSystem.
  def self.instance
    @instance.nil? ? itself : @instance
  end

  def self.all_unlocks
    instance.all_unlocks
  end

  def self.last_unlock
    instance.last_unlock
  end

  def handle_event_with(message)
    raise 'not implemented yet'
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

  def last_unlock
    @last_unlock.nil? ? '' : @last_unlock.to_s
  end

  protected

  def initialize
    @achievement_list = {}
  end

  def achievement_list
    @achievement_list
  end


  def register_achievement(identifier)
    @achievement_list[identifier] = false
  end


  # should return Achievement class
  def self.itself
    @instance = self.new
  end

  def update_list_for(key)
    @achievement_list[key] = true
    @last_unlock = key
  end

end
