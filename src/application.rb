require_relative 'game'
require_relative 'gui'
require_relative 'freeform_gui'
require_relative 'observer'
require_relative 'grid'
require_relative 'settings'
require_relative 'sound_effect'
require_relative 'server'
require_relative 'client'
require_relative 'views/tetris_gui'
require_relative 'views/fractal_view'

# init game
# init gui with game
# init db for scores
# Follows the
class Application < Observer

  # @param args [Hash] containing passed user arguments.
  # @hint: As long as the game is running,#
  # nothing after Settings.gui_to_build.new(@game)
  # will be exectued (since the Tk mainloop is being executed)
  # TODO: have a logger/status thread present.
  def initialize(args)
    Settings.set_mode(args)
    if args[:game] == 6
      FractalView.new
    else
      if args[:multiplayer].to_i == 1
        Client.new
      elsif args[:multiplayer].to_i == 2
        Server.new
      else
        game = Game.new
        game.subscribe(self)
        Settings.gui_to_build.new(game)
      end
    end
  end

  def handle_event
    puts "GAME OVER"
  end

end



