if (RUBY_PLATFORM != "java")
  require_relative 'views/grid_gui'
  require_relative 'views/freeform_gui'
else
  require_relative 'view'
end
require 'control_constants'

# GameMetaData models (game) application specific properties that either determine
# its behaviour or/and its outlook.
module GameMetaData
  include ControlConstants
  module ClassMethods

    def gui_type_as_sym
      underscore(gui_type.to_s)
    end

    protected

    def underscore(word)
      word = word.dup
      word.gsub!(/::/, '/')
      word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
      word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
      word.tr!("-", "_")
      word.downcase!
      word
    end

  end

  def self.included(klass)
    klass.send(:extend, ClassMethods)
  end

  # @return [Array] list of theme sound files located at 'audio/' that should be available
  # within the running target application.
  def self.theme_list
    raise "not implemented yet"
  end

  # @return [Array] list of sound effect files located at 'audio/' that should be available
  # within the running target application.
  def self.sound_effect_list
    raise "not implemented yet"
  end

  # Determines the achivement system that should be used for the current run application.
  #
  # @return [AchievementSystem] used achievement system.
  def self.achievement_system
    raise "not implemented yet"
  end

  # TODO: Export this logic to ClassMethods module.
  #
  # Determines the achivement system that should be used for the current run application.
  #
  # @return [AchievementSystem] used achievement system.
  def self.achievement_system_sym
    raise "not implemented yet"
  end

  # Defines which game map application should be run.
  #
  # @return [GameMap] map of target game that is supposed to be run.
  def self.game_map
    raise "not implemented yet"
  end

  # Hash of required render/drawing specif attributes used by any Gui instance.
  #
  # @return [Hash] of canvas/drawing specific attributes.
  # @hint the following keys have to be specified:
  #   :cell_size [Integer] pixel size of a rendered grid cell.
  #   :width_pixels [Integer] width in canvas pixels of a pixel.
  #   :height_pixels [Integer] height in canvas pixels of a pixel.
  #   :max_width [Integer] canvas pixel width.
  #   :max_height [Integer] canvas pixel height.
  #   :tics_per_second [Integer] how many tics should be performed per second.
  #
  def self.render_attributes
    raise "not implemented yet"
  end

  # @return [Symbol] symbolic identifier of gui that should be for rendering.
  # This representation corresponds to the object type of the target gui.
  def self.gui_type
    raise "not implemented yet"
  end

  # Returns a List of keys that are supported for by a target game.
  # @return [Array] of Strings defining known key constants.
  def self.allowed_controls
    raise "not impleymented yet"
  end

end
