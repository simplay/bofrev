require_relative '../game_meta_data'
require_relative 'game_of_life_map'

class GameOfLifeMetaData
  include GameMetaData

  def self.theme_list
    []
  end

  def self.sound_effect_list
    {}
  end

  def self.achievement_system
    TetrisAchievementSystem.instance
  end

  def self.achievement_system_sym
    :tetris_achievement_system
  end

  def self.game_map
    GameOfLifeMap
  end
end