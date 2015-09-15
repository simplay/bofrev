require 'observable'
require 'score'
require 'ticker'
require 'music_player'
require 'pacer'
require 'game_settings'
require 'event'
require 'waitable'

# A game models a target user application running in a certain mode.
# A game manages how the internal state of the target app is supposed to be updated,
# A manages all relevant model threads (such as the music player
# or the world clock (called ticker )). A Game is a Waitable resource shared among relevant
# business model threads. This allows to wait/signal for a game to have the game in a
# synchronized state.
# Game instances are Observable by Observers. For example, a game is observed by its
# View instances, the Score or the Application.
class Game

  include Observable
  include Waitable

  attr_accessor :map
  attr_reader :ticker_thread

  # Every new Game instance has a fixed number of allowed turns,
  # is marked as not being started yet, has a Score object,
  # A map that belongs to a user selected application, and if determined by
  # the user's runtime arguments, either and/or a music-and a ticker thread.
  def initialize
    @turns_allowed = 10_000_000 # TODO: define a more meaningful ending/condition.
    @has_started = false
    @score = Score.new
    initialize_map
    create_threads
  end

  # Has this Game been started?
  #
  # @hint: Used in View to block user input. The View blocks all user inputs as long as i
  # the game state has not been set to 'started equls true'.
  # @return [Boolean] true if game has been started, otherwise false.
  def started?
    @has_started
  end

  # Starts the game.
  #
  # @hint: Starts all relevant game threads and the game loop.
  def run
    @has_started = true
    start_threads
    perform_loop_step(Event.new('game started'))
  end

  # Increments the Game Score by a certain amound
  #
  # @param value [Integer] value the score should be incremented by.
  # TODO: subscribe score to game and let it update itself
  def update_score_by(value)
    @score.increment_by(value)
  end

  # Runs current game iteration and updates game state accordingly.
  #
  # @hint: This loop runs as long as the game has not finished.
  # @param message [Event] subscriber notification message for current loop iteration.
  def perform_loop_step(message)
    puts "message received: #{message}"
    @turns_allowed = @turns_allowed -1
    if finished?
      perform_loop_update_for(Event.new(:killed, 'game over'))
    else
      perform_loop_update_for(message)
    end
  end

  # Indicates whether the game loop iteration process should stop.
  # This is currently determined by an integer that should be larger than 0,
  # the total number of allowed turns (number of game iterations).
  #
  # @return [Boolean] true if game has finished and otherwise false.
  def finished?
    @turns_allowed < 0
  end

  # Obtain the current score of this player.
  #
  # @return [Integer] current player score.
  def current_player_score
    @score.final_points
  end

  # Set this game into a gameover state.
  # Set allowed turns to -1 which implies a game over, i.e.
  # game#finished? yields true.
  def initiate_game_over
    @turns_allowed = -1
  end

  private

  # Updates current game state according to current game loop conditions.
  #
  # Invokes all relevant handles to update the game state using the
  # received subscription event message within the current game loop.
  #
  # @hint: event messages result from user input, the ticker thread or
  #        other interrupts such as game over events.
  # @param message [Event] subscriber notification message for current loop iteration.
  def perform_loop_update_for(message)
      case message.type
      when :killed
        puts "You scored #{@score.final_points} point(s)!"
        notify_all_targets_of_type(:application)
        notify_all_targets_of_type_with_message(GameSettings.selected_gui, message)
        unsubscribe(GameSettings.selected_gui)
        shut_down_threads
        return
      when :ticker
        @map.handle_ticker_notification
      else
        @map.handle_user_input_notification_for(message)
      end
      notify_all_targets_of_type(GameSettings.selected_gui)
  end

  # Shut down every thread that is currently running.
  # This handle is triggered whenever the Game is supposed to end.
  def shut_down_threads
    @ticker_thread.shut_down if GameSettings.run_game_thread?
    @music_thread.shut_down if GameSettings.run_music?
  end

  # Start all initialized threads (according to provided user inputs).
  def start_threads
    @music_thread.play if GameSettings.run_music?
    @ticker_thread.start if GameSettings.run_game_thread?
  end

  # Create relevant threads based on provided user input
  # set in the GameSettings singleton.
  def create_threads
    if GameSettings.run_music?
      @music_thread = MusicPlayer.new(GameSettings.theme_list)
      append_waitable(@music_thread)
    end
    @ticker_thread = Ticker.new(self, Pacer.new(@score)) if GameSettings.run_game_thread?
  end

  # Initialize a new map instance according to provided user input.
  # @hint: Please see the GameSettings sigleton for further information.
  def initialize_map
    @map = GameSettings.game_map.new(self)
  end

end
