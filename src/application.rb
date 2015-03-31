require_relative 'game'
require_relative 'gui'
require_relative 'observer'
require_relative 'grid'
require_relative 'settings'
require_relative 'sound_effect'
require_relative 'server'
require_relative 'client'
require 'pry'

# init game
# init gui with game
# init db for scores
# Follows the
class Application < Observer
  def initialize(args)
    Settings.set_mode(args)

    if args[:multiplayer].to_i == 1
      Client.new
    elsif args[:multiplayer].to_i == 2
      Server.new
    else
      game = Game.new
      game.subscribe(self)
      Gui.new(game)
    end
  end

  def handle_event
    puts "GAME OVER"
  end

end



