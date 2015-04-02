require_relative 'settings'
require_relative 'game_meta_data'
require_relative 'tetris/tetris_meta_data'
require_relative 'game_of_life/game_of_life_meta_data'
require_relative 'sokoban/sokoban_meta_data'

class GameSettings
  include Settings
  include GameMetaData

  def self.build
    if @game.nil?
      if Settings.selected_game == 1
        @game = TetrisMetaData
      elsif Settings.selected_game == 2
        @game = GameOfLifeMetaData
      elsif Settings.selected_game == 3
        @game = SokobanMetaData
      end
    end
    @game
  end

  def self.game_map
    build.game_map
  end

  def self.theme_list
    build.theme_list
  end

  def self.sound_effect_list
    build.sound_effect_list
  end

  def self.achievement_system
    build.achievement_system
  end

  def self.achievement_system_sym
    build.achievement_system_sym
  end


end