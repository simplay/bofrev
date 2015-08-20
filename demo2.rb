require 'java'
java_import "java.io.FileInputStream"
java_import "java.io.InputStream"
java_import "sun.audio.AudioStream"
java_import "sun.audio.AudioDataStream"
java_import "sun.audio.AudioPlayer"
java_import "sun.audio.AudioData"
java_import "javax.sound.sampled.AudioSystem"
java_import "sun.audio.ContinuousAudioDataStream"
java_import "java.io.BufferedInputStream"

file = "tetris.wav"
input_stream = FileInputStream.new("audio/#{file}")
input_stream2 = FileInputStream.new("audio/#{file}")

stream = BufferedInputStream.new(input_stream, 1024)
ais = AudioSystem.getAudioInputStream( stream )
format = ais.getFormat()

# create correct audio buffer - currently buggy 
# (byte format not correctly assinged)
audio_stream = AudioStream.new(input_stream2)
length = audio_stream.getLength()
buffer = Java::byte[length].new;
ais.read(buffer, 0, length);

ad = AudioData.new(buffer)
ads = AudioDataStream.new(ad)

# for looping sounds
cont_audio_stream = ContinuousAudioDataStream.new(ad)

# for triggerd sounds
audio_stream = AudioDataStream.new(ad);

AudioPlayer.player.start(audio_stream)
