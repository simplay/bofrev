require 'java'
require_relative '../lib/jl1.0.1.jar'
java_import "java.io.FileInputStream"
java_import "javazoom.jl.player.Player"

class JavaMusicPlayer

  def initialize(file)
    @file = file
  end

  def play_loop
    @thread = Thread.new do
      loop do
        run_sample
      end
    end
  end

  def play
    @thread = Thread.new do
      run_sample
    end
  end

  def stop
    @jmp.close unless @jmp.nil?
  end

  protected

  def run_sample
    input_stream = FileInputStream.new(@file)
    Java::JavazoomJlPlayer::Player
    @jmp = Java::JavazoomJlPlayer::Player.new(input_stream)
    @jmp.play
    sleep 0.5
  end

end
