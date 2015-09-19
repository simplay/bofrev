require 'game'
require 'observer'
require 'game_settings'
require 'server'
require 'client'

# Start a bofrev application according to passed user input.
# If no user args were passed, by default, the Tetris game
# application will be started in the normal mode.
class Application < Observer

  # @param args [Hash] containing passed user arguments.
  #   supported hash keys:
  #     :game [Integer] selected game
  #       See REEDME, default is Tetris
  #     :debug [Integer] running mode
  #       0 => play music and run ticker (default)
  #       1 => no music but run ticker
  #       2 => no music, no ticker
  #     :multiplayer [Integer] multiplayer mode
  #       1 => run client
  #       2 => run server
  # @hint: As long as the game is running,
  # Nothing after Settings.gui_to_build.new(@game) will be exectued.
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

  # post steps when game has finished.
  def handle_event
    puts "GAME OVER"
    unlocks = GameSettings.achievement_system.all_unlocks
    puts "nothing unlocked! :( " if unlocks.empty?
    unlocks.each do |unlocked|
      puts "unlocked #{unlocked}"
    end

  end

end
