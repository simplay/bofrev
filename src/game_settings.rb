require 'game_meta_data'
require 'system_information'
require 'singletonable'
require_relative '../demos/tetris/tetris_meta_data'
require_relative '../demos/game_of_life/game_of_life_meta_data'
require_relative '../demos/sokoban/sokoban_meta_data'
require_relative '../demos/snake/snake_meta_data'
require_relative '../demos/pingpong/ping_pong_meta_data'
require_relative '../demos/demo_sprites/demo_sprites_meta_data'
require_relative '../demos/fractals/fractal_meta_data'

# GameSettings is a Singleton that containts all relevant information to start
# and manage a target game.
class GameSettings

  extend Singletonable
  include GameMetaData

  CANVAS_OFFSET_X_WINDOWS = 6
  CANVAS_OFFSET_X_DEFAULT = 1
  CANVAS_OFFSET_Y_DEFAULT = 45

  # Build a new GameSettings singleton containing all relevant runtime information
  # to run a target game (selected by a user).
  #
  # @param arguments [Hash] user passed bofrev runtime arguments
  #   its default value is {}.
  #
  #   The arguments Hash has can include values for the following keys:
  #     :game [Integer] what game should be run
  #       Each game has a known integer associated.
  #       default is 1 (Tetris)
  #       see repository README
  #
  #     :debug [Integer] in which debug mode is bofrev running.
  #         0 run music and ticker thread (default)
  #         1 only run ticker thread but no music
  #         2 only accept user input but do not run any ticker nor any music thread.
  #
  # @hint: The selected_game is determined by derive_game_model.
  #   using the default argument value correspond to passing the
  #   Hash {:game => 1, :debug => 0}
  #
  # @example
  #   GameSettings.new({:game => 7, :debug => 2})
  #     prepares all relevant settings for running
  #     the game 7 in debug mode 2.
  #     However, during runtime a developer is supposed to invoke
  #     GameSettings.singleton({:game => 7, :debug => 2})
  def initialize(arguments={})
    @selected_game = arguments[:game] || 1
    @selected_mode = arguments[:debug] || 0
    @game_meta_data = derive_game_model
  end

  # Obtain the number of the selected_game.
  # This number is used to fetch the correct GameMetaData
  # contained in GameSettings#game_meta_data.
  #
  # @hint: its value is given by bofrev's runtime argument -g
  #   See the README.md for further information.
  # @return [Integer] number value of selected game.
  #   default value is 1.
  def selected_game
    @selected_game
  end

  # Obtain the number of the selected game debugging mode.
  #
  # @hint: its value is given by bofrev's runtime argument -d
  #   See the README.md for further information.
  # @return [Integer] number value of selected debug mode.
  #   default value is 0.
  def selected_mode
    @selected_mode
  end

  # Obtain a GameMetaData according to the selected game.
  # Such meta data contains game specific information used to
  # build a selected game, defining its behaviour and look.
  #
  # @hint: See GameSettings#derive_game_model,
  #   value is bofrev runtime argument -g
  #   Visit the module GameMetaData for more information.
  # @return [GameMetaData] instance that belongs to selected game.
  #   default value is TetrisMetaData
  def game_meta_data
    @game_meta_data
  end

  # Retrieve the selected game meta data file that belongs to the selected game.
  #
  # @return [GameMetaData] according to the selected game number.
  def derive_game_model
    case @selected_game
    when 1
      TetrisMetaData
    when 2
      GameOfLifeMetaData
    when 3
      SokobanMetaData
    when 4
      SnakeMetaData
    when 5
      PingPongMetaData
    when 6
      FractalMetaData
    when 7
      DemoSpritesMetaData
    end
  end

  # Indicates whether we should the we run the MusicPlayer during the program exection.
  #
  # @hint: Is only true if the user is not in debug mode (1 or 2).
  # and the target app has some themes songs assigned.
  # @return [Boolean] is true if MusicPlayer should run, otherwise false.
  def self.run_music?
    singleton.selected_mode < 1 && !(theme_list).empty?
  end

  # Indicates whether the Thicker should run.
  #
  # @hint: The Thicker thread is responsible to model a world clock.
  #   it periodically updates the game in a prespecified rate.
  # @return [Boolean] is true if Thicker should run, otherwise false.
  def self.run_game_thread?
    singleton.selected_mode < 2
  end

  # Obtain the GameSettings singleton GameMetaData which is determined
  # by the given user startup arguments.
  #
  # @hint: See GameSettings#derive_game_model,
  #   value is bofrev runtime argument -g
  #   Visit the module GameMetaData for more information.
  # @return [GameMetaData] instance that belongs to selected game.
  #   default value is TetrisMetaData
  def self.game_meta_data
    singleton.game_meta_data
  end

  # Returns the type of cavas that should be used for drawing.
  #
  # @return [Canvas, ACanvas < Canvas] a canvas that should be used for drawing.
  def self.canvas
    game_meta_data.canvas
  end

  # Normaliyed a given View class name (given by GameMetaData#gui_type)
  # to its sybol representation.
  #
  # @return [Symbol] symbolic representation of a given View Class.
  def self.selected_gui
    game_meta_data.gui_type_as_sym
  end

  # Defines which View should be used by the target application.
  # Every custom View class should implement View
  #
  # @return [View, AView < View] name of View or a descendent that should
  # be used for building the application's gui.
  def self.gui_to_build
    game_meta_data.gui_type
  end

  # Get the Map that should be build for the target application.
  # A particular field in GameMetaData
  #
  # @hint: The target Map class is stored in the GameMetaData
  #   that belongs to the target application.
  #   Can be obtained by GameSettings#derive_game_model
  # @return [Map] a class that inherits from Map implementing its methods.
  def self.game_map
    game_meta_data.game_map
  end

  # Retrive a list of audio filepaths that should be played when running a target Game.
  #
  # @return [Array] a list of String defining filepaths to songs that should be played
  #   by the MusicPlayer when running a Game in the normal mode.
  def self.theme_list
    game_meta_data.theme_list
  end

  # Retuns a Hash containing the sound_effcts. Each key is an identifier that
  # can be used to play this sound effect within the engine by
  # using the SoundEffectPlayer. Each key points to a String whould refers
  # @return [Hash] with known sound effect identifiers as keys and values containing
  #   the filepaths of the sound effect audio files.
  # to the file path of a sound effect.
  def self.sound_effect_list
    game_meta_data.sound_effect_list
  end

  # Determines the AchivementSystem that should be used for the target application.
  #
  # @return [AchievementSystem] used achievement system.
  def self.achievement_system
    game_meta_data.achievement_system
  end

  # Determines the symbolic representation of AchivementSystem
  # that should be used for the target application.
  # Is a particular field in GameMetaData.
  #
  # @hint: A particular AchievementSystem is supposed to be a descendent of
  #   AchievementSystem.
  # @return [Symbol] symbolid represenation of GameMetaData#achievement_system.
  def self.achievement_system_sym
    game_meta_data.achievement_system_sym
  end

  # Hash of required render/drawing properties used by any GUI instance.
  # Return a Hash containing meta information about how model data
  # is supposed to be drawn onto a View's Canvas. For example this hash indicates
  # a Canvas' resolution, its number of pixels, how many times it
  # is supposed to be redrawn (i.e. how many times it should be
  # updated/redrawn per second).
  #
  # @return [Hash] of canvas/drawing specific attributes.
  def self.render_attributes
    game_meta_data.render_attributes
  end

  # A particular field in GameMetaData
  # Returns a Hash of controls that are supported by a target game.
  # All controls listed in this Hash can be defined in a target Map descendent class
  # to define user input behavior.
  # Even a key is defined in a Map, but not occuring in this list,
  # it will not handle the defined behavior.
  #
  # @return [Array] of Strings defining known key constants.
  def self.allowed_controls
    game_meta_data.allowed_controls
  end

  # Fetch the cell size of a canvas.
  def self.cell_size
    render_attributes[:cell_size]
  end

  # Fetch the number of width pixels of the target Canvas.
  def self.width_pixels
    render_attributes[:width_pixels]
  end

  # Fetch the number of height pixels of the target Canvas.
  def self.height_pixels
    render_attributes[:height_pixels]
  end

  def self.max_height
    render_attributes[:max_height]
  end

  def self.max_width
    render_attributes[:max_width]
  end

  def self.tics_per_second
    render_attributes[:tics_per_second]
  end

  # Should a grid overlayer be shown when the application is run.
  #
  # @hint: Used by games like Tetris. Not used by games Like DemoSprites.
  # @return [Boolean] true if a grid should be shown, otherwise false.
  def self.show_grid?
    grid_is_shown = render_attributes[:show_grid]
    grid_is_shown.nil? ? true : grid_is_shown
  end

  # Get top level folder name where the audio folder lies in.
  #
  # @hint: In case bofrev is called by its executable jar, there is an additional
  # namespace folder called 'bofrev'. Every folder of the bofrev folder is put into
  # this parent folder by the jar. When running bofrev from the code, there is no such parent
  # folder. This is why we return for this case the prefix ''.
  #
  # @return [String] 'bofrev/' if bofrev.jar is called and '' otherwise.
  def self.audio_filefolder_prefix
    SystemInformation.called_by_jar? ? 'bofrev/' : ''
  end

  # return [Array] including canvas offsets for packing into main_frame.
  def self.canvas_offsets
    on_windows = SystemInformation.running_on_windows?
    offset_x = on_windows ? CANVAS_OFFSET_X_WINDOWS
                          : CANVAS_OFFSET_X_DEFAULT
    offset_y = CANVAS_OFFSET_Y_DEFAULT
    [offset_x, offset_y]
  end

  def self.canvas_width
    canvas_offsets[0] + max_width
  end

  def self.canvas_height
    canvas_offsets[1] + max_height
  end

end
