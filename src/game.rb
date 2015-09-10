require 'observable'
require 'score'
require 'ticker'
require 'music_player'
require 'pacer'
require 'game_settings'
require 'event'
require 'waitable'

class Game
  include Observable
  include Waitable

  attr_accessor :map
  attr_reader :ticker_thread

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
  def finished?
    @turns_allowed < 0
  end

  def current_player_score
    @score.final_points
  end

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

  def shut_down_threads
    @ticker_thread.shut_down if GameSettings.run_game_thread?
    @music_thread.shut_down if GameSettings.run_music?
  end

  def start_threads
    @music_thread.play if GameSettings.run_music?
    @ticker_thread.start if GameSettings.run_game_thread?
  end

  def create_threads
    if GameSettings.run_music?
      @music_thread = MusicPlayer.new(GameSettings.theme_list)
      append_waitable(@music_thread)
    end
    @ticker_thread = Ticker.new(self, Pacer.new(@score)) if GameSettings.run_game_thread?
  end

  def initialize_map
    @map = GameSettings.game_map.new(self)
  end

end
