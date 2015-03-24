require_relative 'map'
require_relative 'gui'
require_relative 'observable'
require_relative 'shape'
require_relative 'point2f'
require_relative 'score'

class Game
  RUN_GAME_THREAD = true
  include Observable

  TICKS_PER_SECOND = 1 # determines the game speed.

  attr_accessor :map
  def initialize
    @turns_allowed = 10_000 # TODO: define a more meaningful ending/condition.
    @score = Score.new
    initialize_map
    puts @map.to_s
  end

  # spawn game thread.
  # handle map state here- care about race-condition with provided user input
  def run
    if RUN_GAME_THREAD
      spawn_ticker
      start_music_player
    end

    perform_loop_step("game started")
  end

  def update_score_by(value)
    @score.increment_by(value)
  end

  def perform_loop_step(message)
    if finished?
      @music_thread.shut_down if RUN_GAME_THREAD
      unsubscribe(:gui)
      notify_all_targets_of_type(:application)
      puts "You scored #{@score.final_points} point!"
    else
      puts "message received: #{message}"

      @map.process_event(message)

      puts @map.to_s

      notify_all_targets_of_type(:gui)
    end
  end

  def finished?
    @turns_allowed = @turns_allowed -1
    @turns_allowed < 0
  end

  private

  def start_music_player
    @music_thread = MusicPlayer.new("audio/tetris_tone_loop.mp3").play
  end

  def spawn_ticker
    @game_thread = Thread.new do
      loop do
        @map.move_shape_one_down
        notify_all_targets_of_type(:gui)
        sleep(1.0 / TICKS_PER_SECOND) # sleep time in [s]
        break if finished?
      end
    end
  end

  def initialize_map
    @map = Map.new(self)
  end

end