require_relative 'map'
require_relative 'gui'
require_relative 'observable'

class Game

  include Observable

  attr_accessor :state

  def initialize
    perform_loop_step("game started")
  end

  def perform_loop_step(message)
    puts "message received: #{message}"
    notify_all_targets_of_type(:gui)
  end
  
end