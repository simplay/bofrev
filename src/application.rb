require 'game'
require 'observer'
require 'game_settings'

# init gui with game
# Follows the
class Application < Observer

  # @param args [Hash] containing passed user arguments.
  # @hint: As long as the game is running,#
  # nothing after Settings.gui_to_build.new(@game)
  # will be exectued (since the Tk mainloop is being executed)
  def initialize(args)
    GameSettings.build_from(args)
    game = Game.new
    game.subscribe(self)
    GameSettings.gui_to_build.new(game)
  end

  def handle_event
    puts "GAME OVER"
  end

end
