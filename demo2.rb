require 'java'
require 'libs/jl1.0.1.jar'

java_import "java.io.FileInputStream"
java_import "javazoom.jl.player.Player"

file = "tetris_tone_loop.mp3"
input_stream = FileInputStream.new("audio/#{file}")
player = Player.new(input_stream)
player.play(30)
@thread = Thread.new do
  loop do
    puts "is complete: #{player.isComplete} p: #{player.getPosition}"
      input_stream = FileInputStream.new("audio/#{file}")
      player = Player.new(input_stream)
      player.play(30)
  end
end
puts "foo"
@thread.join
