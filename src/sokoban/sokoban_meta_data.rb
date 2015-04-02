require_relative '../game_meta_data'
require_relative 'sokoban_map'
require_relative '../tetris/tetris_achievement_system'

class SokobanMetaData
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
    SokobanMap
  end
end