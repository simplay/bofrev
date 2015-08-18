require 'observable'
require 'score'
require 'ticker'
require 'music_player'
require 'pacer'
require 'game_settings'
require 'event'

class Game
  include Observable

  attr_accessor :map
  attr_reader :ticker_thread

  def initialize
    @turns_allowed = 10_000_000 # TODO: define a more meaningful ending/condition.
    @turns_allowed = 10 # TODO: define a more meaningful ending/condition.
    @score = Score.new
    initialize_map
    create_threads
    set_up_exit_handle
  end

  # spawn game thread.
  # handle map state here- care about race-condition with provided user input
  def run
    start_threads
    perform_loop_step(Event.new('game started', nil))
  end

  # TODO: subscribe score to game and let it update itself
  def update_score_by(value)
    @score.increment_by(value)
  end

  # @param message [Event]
  def perform_loop_step(message)
    puts "message: #{message}"
    if finished?
      shut_down_threads
      unsubscribe(GameSettings.selected_gui)
      notify_all_targets_of_type(:application)
      puts "You scored #{@score.final_points} point!"
    else
      puts "message received: #{message}"
      @map.process_event(message)
      notify_all_targets_of_type(GameSettings.selected_gui)
    end
    @turns_allowed = @turns_allowed -1
  end

  def finished?
    @turns_allowed < 0 || @brute_fore_kill
  end

  def current_player_score
    @score.final_points
  end

  def initiate_game_over
    @brute_fore_kill = true
    @turns_allowed = -1
    perform_loop_step('killed')
  end

  private

  def shut_down_threads
    @music_thread.shut_down if GameSettings.run_music?
    @ticker_thread.shut_down if GameSettings.run_game_thread?
  end

  def start_threads
    @music_thread.play if GameSettings.run_music?
    @ticker_thread.start if GameSettings.run_game_thread?
  end

  def create_threads
    @music_thread = MusicPlayer.new(GameSettings.theme_list)
    @ticker_thread = Ticker.new(self, @map, Pacer.new(@score), GameSettings.selected_gui)
  end

  def initialize_map
    @map = GameSettings.game_map.new(self)
  end

  def set_up_exit_handle
    @brute_fore_kill = false
    at_exit do
      shut_down_threads
    end
  end

end
