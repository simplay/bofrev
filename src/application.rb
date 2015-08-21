require 'game'
require 'observer'
require 'game_settings'
require 'server'
require 'client'

# init gui with game
# Follows the
class Application < Observer

  # @param args [Hash] containing passed user arguments.
  # @hint: As long as the game is running,#
  # nothing after Settings.gui_to_build.new(@game)
  # will be exectued (since the Tk mainloop is being executed)
  def initialize(args)
    GameSettings.build_from(args)
    if args[:multiplayer].to_i == 1
      Client.new
    elsif args[:multiplayer].to_i == 2
      Server.new
    else
      game = Game.new
      game.subscribe(self)
      GameSettings.gui_to_build.new(game)
    end
  end

  def handle_event
    puts "GAME OVER"
  end

end
