require_relative 'map'
require_relative 'gui'
require_relative 'observable'
require_relative 'shape'
require_relative 'point2f'
require_relative 'score'
require_relative 'ticker'
require_relative 'music_player'
require_relative 'settings'
require_relative 'pacer'

class Game
  include Observable
  include Settings

  attr_accessor :map
  def initialize
    @turns_allowed = 10_000 # TODO: define a more meaningful ending/condition.
    @score = Score.new
    initialize_map

    create_threads
    set_up_exit_handle
  end

  # spawn game thread.
  # handle map state here- care about race-condition with provided user input
  def run
    start_threads
    perform_loop_step("game started")
  end

  # TODO: subscribe score to game and let it update itself
  def update_score_by(value)
    @score.increment_by(value)
  end

  def perform_loop_step(message)
    if finished?
      shut_down_threads
      unsubscribe(:gui)
      notify_all_targets_of_type(:application)
      puts "You scored #{@score.final_points} point!"
    else
      puts "message received: #{message}"
      @map.process_event(message)
      notify_all_targets_of_type(:gui)
    end
  end

  def finished?
    @turns_allowed = @turns_allowed -1
    @turns_allowed < 0 || @brute_fore_kill
  end

  def current_player_score
    @score.final_points
  end

  private

  def shut_down_threads
    @music_thread.shut_down if Settings.run_music?
    @ticker_thread.shut_down if Settings.run_game_thread?
  end

  def start_threads
    @music_thread.play if Settings.run_music?
    @ticker_thread.start if Settings.run_game_thread?
  end

  def create_threads
    @music_thread = MusicPlayer.new("audio/tetris_tone_loop.mp3")
    @ticker_thread = Ticker.new(self, @map, Pacer.new(@score))
  end

  def initialize_map
    @map = Map.new(self)
  end

  def set_up_exit_handle
    @brute_fore_kill = false
    at_exit do
      shut_down_threads
    end
  end

end