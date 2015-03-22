require_relative 'game'
require_relative 'gui'
require_relative 'observer'

# init game
# init gui with game
# init db for scores
class Application < Observer
  def initialize
    game = Game.new
    Gui.new(game)
  end

  def handle_event(message)
    puts "GAME OVER"
  end

end