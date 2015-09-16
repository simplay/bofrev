require_relative 'view'
require 'freeform_canvas'
require 'fractal_canvas'
require 'control_constants'

# GameMetaData is a module taht models (game-) application specific properties that
# either determine its behaviour or/and its outlook. Every Game has a own
# own MyGameMetaData class that is supposed to extend GameMetaData and implement all
# abstract methods as class methods.
#
# This is usually done by extending GameMetaData in your class and implementing
# all methods that raise an Exception "not implemented yet".
#
# @hint: When extending the GameMetaData module in your MyGameMetaData class,
# please implement the following methods:
#   self.theme_list
#   self.sound_effect_list
#   self.achievement_system
#   self.game_map
#   self.canvas
#   self.render_attributes
#   self.gui_type
#   self.allowed_controls
#
module GameMetaData

  # Include ControlConstants in your MyGameMetaData that extends GameMetaData.
  #
  # @param klass [MyGameMetaData] class that extends the GameMetaData module.
  def self.extended(klass)
    klass.send :include, ControlConstants
  end

  # Returns the type of cavas that should be used for drawing.
  #
  # @example: Taken from TetrisMetaData
  #
  #   def self.canvas
  #     FreeformCanvas
  #   end
  #
  # @raise [RuntimeError] with the message "not implemented yet".
  # @return [Canvas, ACanvas < Canvas] a canvas that should be used for drawing.
  def canvas
    raise "not implemented yet"
  end

  # Retrive a list of audio filepaths that should be played when running a target Game.
  #
  # @hint: Audio files are located in 'audio/'.
  # @example: Taken from TetrisMetaData
  #
  #   def self.theme_list
  #     ['audio/tetris_tone_loop.wav']
  #   end
  #
  # @raise [RuntimeError] with the message "not implemented yet".
  # @return [Array] a list of String defining filepaths to songs that should be played
  #   by the MusicPlayer when running a Game in the normal mode.
  def theme_list
    raise "not implemented yet"
  end

  # @example: Taken from TetrisMetaData
  #
  #   def self.sound_effect_list
  #     {
  #         :jump => "audio/jump.wav",
  #         :explosion => "audio/explosion.wav",
  #         :kick => "audio/kick.wav"
  #     }
  #   end
  #
  # @raise [RuntimeError] with the message "not implemented yet".
  # @return [Array] list of sound effect files located at 'audio/' that should be available
  # within the running target application.
  def sound_effect_list
    raise "not implemented yet"
  end

  # Determines the AchivementSystem that should be used for the target application.
  #
  # @hint: An particular AchievementSystem is supposed to be a descendent of
  #   AchievementSystem.
  # @example: Taken from TetrisMetaData
  #
  #   def self.achievement_system
  #     TetrisAchievementSystem.instance
  #   end
  #
  # @raise [RuntimeError] with the message "not implemented yet".
  # @return [AchievementSystem] used achievement system.
  def achievement_system
    raise "not implemented yet"
  end

  # Determines the sybolic representation of AchivementSystem
  # that should be used for the target application.
  #
  # @hint: An particular AchievementSystem is supposed to be a descendent of
  #   AchievementSystem.
  # @return [Symbol] symbolid represenation of GameMetaData#achievement_system.
  def achievement_system_sym
    model_type_as_sym(achievement_system.class)
  end

  # Defines which Game Map should be run.
  #
  # @hint: Every running Game has to define AMap class that inherits from Map.
  #   AMap defines the behaviour of the Game that should be run. This means, it
  #   defines how user input should be handled and how the game state should be updated
  #   at a time step (determined by a Ticker thread).
  # @example: Taken from TetrisMetaData
  #
  #   def self.game_map
  #     TetrisMap
  #   end
  #
  # @raise [RuntimeError] with the message "not implemented yet".
  # @return [GameMap] map of target game that is supposed to be run.
  def game_map
    raise "not implemented yet"
  end

  # Hash of required render/drawing specif attributes used by any Gui instance.
  # Return a Hash containing meta infromation about how model data
  # is supposed to be drawn onto a View's Canvas. For example this hash indicates
  # a Canvas' resolution, its number of pixels, how many times it
  # is supposed to be redrawn (i.e. how many times it should be
  # updated/redrawn per second).
  #
  # @example: Extracted from TetrisMetaData
  #
  #   def self.render_attributes
  #     {
  #         :cell_size => 20,
  #         :width_pixels => 10,
  #         :height_pixels => 20,
  #         :max_width => 200,
  #         :max_height => 420,
  #         :tics_per_second => 1
  #     }
  #   end
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
  # @raise [RuntimeError] with the message "not implemented yet".
  # @return [Hash] of canvas/drawing specific attributes.
  def render_attributes
    raise "not implemented yet"
  end

  # Defines which Vie should be used by the target application.
  #
  # @hint: A View defines how the gui will look like.
  # @example: Taken from TetrisMetaData
  #
  #   def self.gui_type
  #     View
  #   end
  #
  # @raise [RuntimeError] with the message "not implemented yet".
  # @return [View, AView < View] name of View or a descendent that should
  # be used for building the application's gui.
  def gui_type
    raise "not implemented yet"
  end

  # Returns a Hash of controls that are supported for by a target game.
  # All controls listed in this Hash can be defined in a target Map descendent class
  # to define user input behavior.
  # Even a key is defined in a Map, but not occuring in this list,
  # it will not handle the defined behavior.
  #
  # @example: Taken from GameOfLifeMetaData
  #
  #   def self.allowed_controls
  #     {
  #       :keyboard => [A_KEY, S_KEY, W_KEY],
  #       :mouse => [LEFT_MOUSE_BUTTON_PRESSED, LEFT_MOUSE_BUTTON_DRAGGED]
  #     }
  #   end
  #
  # @hint: The Hash of allowed controls has two known keys,
  #   :keyboard, that references an Array,
  #   containing all whitelisted keyboard controls and
  #   :mouse, an Array containing all whitelisted mouse events the app should listen to.
  #   Again, please note that only controlls included in this white-list
  #   can have a behavior that is actually run.
  #   Please have a look into the module ControlConstants to see what control constants are
  #   currently defined.
  # @raise [RuntimeError] with the message "not implemented yet".
  # @return [Array] of Strings defining known key constants.
  def allowed_controls
    raise "not impleymented yet"
  end

  # Normaliyed a given View class name (given by GameMetaData#gui_type)
  # to its sybol representation.
  #
  # @return [Symbol] symbolic representation of a given View Class.
  def gui_type_as_sym
    model_type_as_sym(gui_type)
  end

  # Obtain a normalized symbol representation of a given Class.
  #
  # @param model [Class] that should be normalized in representated as a symbol.
  # @return [Symbol] normalized symbolic representation.
  def model_type_as_sym(model)
    underscore(model.to_s).to_sym
  end

  # Normalizes a given String.
  #
  # @example:
  #   word = "FooBar"
  #   underscore(word) #=> "foo_bar"
  #
  # @hint: Normalizing means to remove namespaces, downcasing
  #   and trimming previousely upcased words by a '_'.
  # @param word [String] word to normalize
  # @return [String] normalized word
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
