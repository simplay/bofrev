require_relative "src/java_music_player"

mp = JavaMusicPlayer.new("audio/tetris_tone_loop.mp3")
t = mp.play_loop
t.join
puts "foobar"
