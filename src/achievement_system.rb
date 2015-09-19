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

  # Retrieve all currently unlocked achievements as a list of string of their identifier.
  #
  # @return [Array] of String identifiers of all unlocked achievements
  def self.all_unlocks
    instance.all_unlocks
  end

  # Obtain the last unlocked achievement.
  # @hint: Corresponds to head in list #all_unlocks.
  #   can be equal '' if there is no unlocked achievement yet.
  #
  # @return [String] String identifier in unlocked achievements.
  def self.last_unlock
    instance.last_unlock
  end

  # @param message [Event] message received from an observed Observable instance.
  #
  # @info inherited from Observer
  def handle_event_with(message)
    raise 'not implemented yet'
  end

  # Retrieve all currently unlocked achievements as a list of string of their identifier.
  #
  # @return [Array] of String identifiers of all unlocked achievements
  def all_unlocks
    unlocked_achievements = achievement_list.select do |_, value|
      value
    end
    unlocked_achievements.map do |key, _|
      [key.to_s]
    end
  end

  # Obtain the last unlocked achievement.
  # @hint: Corresponds to head in list #all_unlocks.
  #   can be equal '' if there is no unlocked achievement yet.
  #
  # @return [String] String identifier in unlocked achievements.
  def last_unlock
    @last_unlock.nil? ? '' : @last_unlock.to_s
  end

  protected

  # Initializes a new AchievementSystem.
  # Every AchievementSystem has an empty Hash of achievements.
  # This list marks achievement Achievement#identifier as true or false,
  # depending on whether they have been achieved or not.
  def initialize
    @achievement_list = {}
  end

  # Get this singleton-s achievement list
  #
  # @return [Hash] internal achievement list.
  def achievement_list
    @achievement_list
  end

  # Add a new Achievement identifier to the internal
  # achievement list and marks it as locked (i.e. false).
  #
  # @param identifier [Symbol] identifier of target Achievement.
  def register_achievement(identifier)
    @achievement_list[identifier] = false
  end

  # Make a new instance of AchievementSystem or
  # an inheriting class of AchievementSystem acting as a singleton.
  #
  # @return [AchievementSystem] returns the singleton.
  def self.itself
    @instance = self.new
  end

  # Marks a target Achievement as unlocked.
  # This achievement will then appear in the #all_unlocks list.
  #
  # @param key [Symbol] identifier of target Achievement.
  def update_list_for(key)
    @achievement_list[key] = true
    @last_unlock = key
  end

end
