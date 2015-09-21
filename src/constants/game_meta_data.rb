require 'view'
require 'freeform_canvas'
require 'control_constants'
require 'utility'

# GameMetaData is a module that models a (game-) application specific properties
# such as its behaviour and/or its appearance. Every Game has an
# own MyGameMetaData class that is supposed to extend GameMetaData and implement all
# abstract methods as class methods.
#
# The abstract methods that need to be overwritten are
# (for their respective functionality, see below):
#
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
  # A Canvas selects the Drawables it wants to drawn,
  # and also affects the look of the gui (defined in MainFrame).
  #
  # @hint: Currently, there is only one kind of Cavas available,
  #   the FreeformCanvas canvas.
  #   Every Canvas is a descendent of Canavas.
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

  # Retrive a list of audio files that should be played when running a target Game.
  #
  # @hint: Audio files are located in 'audio/'. Currently, only .wav audio files are supported.
  #   Note that the list actually returns the filepaths of the audio files that should be
  #   played during program execution. A filepath is the path and the file name, including
  #   its file type extension.
  #   E.g. 'audio/foobar.wav' is the the .wav file foobar stores in the folder audio/
  # @info: Visit the class MusicPlayer for further information.
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

  # Retuns a Hash containing an application's sound effcts.
  # Each Hash key points to a String that refers
  # to the audio file path of a particular sound effect.
  # Therefore, each key is a unique identifier to a certain sound effect.
  # A sound effect can be played by invoking play on a SoundEffectPlayer
  # instance with a given identifier.
  #
  # @info: Currently, only .wav sound effect audio files are suppored.
  # @hint: Every class that inherits from Map has can play the sounds defined
  #   in this Hash.
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
  #   Then in TetrisMap it is possible to play a sound effect by
  #   calling @sound_effect.play(:jump) to play the jump sound and so forth.
  #
  # @raise [RuntimeError] with the message "not implemented yet".
  # @return [Hash] with known sound effect identifiers as keys and values containing
  #   the filepaths of the sound effect audio files.
  def sound_effect_list
    raise "not implemented yet"
  end

  # Determines the AchivementSystem that should be used for the target application.
  #
  # @hint: A particular AchievementSystem is supposed to be a descendent of
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

  # Defines which Game Map should be run.
  #
  # @hint: Every running Game has to define AMap class that inherits from Map.
  #   AMap defines the behaviour of the Game that should be run. This means it
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

  # Return a Hash containing meta information about how model data
  # is supposed to be drawn onto a View's Canvas.
  # in other words, it returns a hash of render/drawing properties used
  # by any View, MainFrame and Canvas. For example this hash contrains
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
  # @hint the following render_attributes hash keys have to be specified:
  #   :cell_size [Integer] pixel size of a rendered grid cell.
  #     How many pixels does a pixel correspond to.
  #     A 1x1 grid cell correspond to a cell_size x cell_size super pixel.
  #   :width_pixels [Integer] number of pixels in width.
  #     How many pixels are there per row.
  #   :height_pixels [Integer] number of pixels in height.
  #     How many pixels are there per column.
  #   :max_width [Integer] canvas window pixel width,
  #     window will be scaled to this width.
  #     Idally, max_width is equal to cell_size*width_pixels
  #     to fit into the canvas optimal in width.
  #   :max_height [Integer] canvas window pixel height,
  #     window will be scaled to this height.
  #     Idally, max_height is equal to cell_size*height_pixels
  #     to fit into the canvas optimal in height.
  #   :tics_per_second [Integer] how many redraws/updates should be performed per second.
  #     When its value is set to something <= 0, then the Ticker thread will not run.
  #
  # @raise [RuntimeError] with the message "not implemented yet".
  # @return [Hash] of canvas/drawing specific attributes.
  def render_attributes
    raise "not implemented yet"
  end

  # Defines which View should be used by the target application.
  # Every custom View class should implement View
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

  # Returns a Hash of controls that are supported by a target game.
  # Acts as the whitelist of Controls a View will listen to.
  # The behavior of how an application should handle certain control events
  #  - which it listens to - is defined in the appropriate Map
  # descendent class of the target application. Thus, despite having
  # defined some behavior in a Map, the application
  # will only react to whitelisted controls.
  #
  # @info: keys that occur in this list of controls are listening to
  # keystroke or mouse movement events. Therefore, even a key is defined in
  # a Map, but it is not included in this list,
  # it will not handle the defined Map behavior,
  # when the corresponding key event occurs.
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
  #     containing all whitelisted keyboard controls and
  #   :mouse, an Array containing all whitelisted mouse events the app should listen to.
  #     Again, please note that only controlls included in this white-list
  #     can have a behavior that is actually run.
  #   Please have a look into the module ControlConstants to see what control constants are
  #     currently defined.
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

  # Determines the symbolic representation of AchivementSystem
  # that should be used for the target application.
  #
  # @hint: A particular AchievementSystem is supposed to be a descendent of
  #   AchievementSystem.
  # @return [Symbol] symbolid represenation of GameMetaData#achievement_system.
  def achievement_system_sym
    model_type_as_sym(achievement_system.class)
  end

  # Obtain a normalized symbol representation of a given Class.
  #
  # @param model [Class] that should be normalized in representated as a symbol.
  # @return [Symbol] normalized symbolic representation.
  def model_type_as_sym(model)
    Utility.underscore(model.to_s).to_sym
  end

end
