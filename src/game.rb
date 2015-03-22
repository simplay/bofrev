require_relative 'map'
require_relative 'gui'
require_relative 'observable'

class Game

  include Observable

  attr_accessor :map
  def initialize
    @turns_allowed = 2
    initialize_map
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

  def initialize_map
    @map = Map.new
    @map.set_field_at(0,0,'red')
    @map.set_field_at(1,0,'red')
    @map.set_field_at(2,0,'red')
  end

end