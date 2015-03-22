require_relative 'map'
require_relative 'gui'
require_relative 'observable'

class Game

  include Observable

  attr_accessor :state

  def initialize
    #run_main_loop
  end

  private

  def perform_loop_step
    input = read_user_input
    handle(input)
    print_map
    notify_all_targets_of_type(:gui)
  end

  def run_main_loop
    print_map
    begin
      perform_loop_step
    end until finished?
    finish_sequence
  end

  def read_user_input
    printf "perform action: "
    @state = gets.chomp
  end

  def finished?
    state == "-1"
  end

  # @param user_input [String] given user input
  def handle(user_input)
    puts "#{user_input} HANDLING"
  end

  def finish_sequence
    system "clear"
    printf "game finished..."
    gets.chomp
    system "clear"
  end

  def print_map
    system "clear"
    puts "MAP"
  end

end