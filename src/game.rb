require_relative 'map'
require_relative 'gui'
require_relative 'observable'

class Game

  include Observable

  TICKS_PER_SECOND = 1 # determines the game speed.

  attr_accessor :map
  def initialize
    @turns_allowed = 6
    initialize_map
  end

  # spawn game thread.
  # handle map state here- care about race-condition with provided user input
  def run
    spawn_ticker
    perform_loop_step("game started")
  end

  def perform_loop_step(message)
    if finished?
      unsubscribe(:gui)
      notify_all_targets_of_type(:application)
    else
      puts "message received: #{message}"
      notify_all_targets_of_type(:gui)
    end
  end

  def finished?
    @turns_allowed = @turns_allowed -1
    @turns_allowed < 0
  end

  private

  def spawn_ticker
    @game_thread = Thread.new do
      loop do
        puts "TICK: update map state"
        sleep(1.0 / TICKS_PER_SECOND) # sleep time in [s]
        break if finished?
      end
    end
  end

  def initialize_map
    @map = Map.new
    @map.set_field_at(0,0,'red')
    @map.set_field_at(1,0,'red')
    @map.set_field_at(2,0,'red')
  end

end