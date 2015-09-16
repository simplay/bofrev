require_relative 'view'
require 'freeform_canvas'
require 'fractal_canvas'
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

  def self.canvas
    raise "not implemented yet"
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
  # @example: render_attributes =
  #             {
  #                 :cell_size => 20,
  #                 :width_pixels => 10,
  #                 :height_pixels => 20,
  #                 :max_width => 200,
  #                 :max_height => 420,
  #                 :tics_per_second => 1
  #             }
  #
  # @hint the following keys have to be specified:
  #   :cell_size [Integer] pixel size of a rendered grid cell.
  #     How many pixels does a pixel correspond to.
  #     A 1x1 grid cell correspond to a cell_size x cell_size super pixel.
  #   :width_pixels [Integer] number of pixels in width.
  #     How many pixels are there per row.
  #   :height_pixels [Integer] number of pixels in height.
  #     How many pixels are there per column.
  #   :max_width [Integer] canvas window width resolution.
  #   :max_height [Integer] canvas window pixel height resoultion.
  #   :tics_per_second [Integer] how many tics should be performed per second.
  #
  # @return [Hash] of canvas/drawing specific attributes.
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
