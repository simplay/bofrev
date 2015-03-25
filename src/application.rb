require_relative 'game'
require_relative 'gui'
require_relative 'observer'
require_relative 'grid'
require_relative 'settings'

require 'pry'

# init game
# init gui with game
# init db for scores
class Application < Observer
  def initialize(args)
    Settings.set_mode(args)
    game = Game.new
    game.subscribe(self)
    Gui.new(game)
  end

  def handle_event
    puts "GAME OVER"
  end

end



