require 'java'
require_relative '../lib/jl1.0.1.jar'
java_import "java.io.FileInputStream"
java_import "javazoom.jl.player.advanced.AdvancedPlayer"
java_import "javazoom.jl.player.advanced.PlaybackListener"

class JavaMusicPlayer

  # Java::JavazoomJlPlayerAdvanced::PlaybackListener
  class MyPlaybackListener < Java::JavazoomJlPlayerAdvanced::PlaybackListener

    def playbackFinished(event)
      puts "finished"
    end

    def playbackStarted(event)
      puts "started"
    end
  end

  def initialize(file)
    @file = file
    @is_runnable = true
    @pbl = MyPlaybackListener.new
  end

  def pause
    @is_runnable = false
    @jmp.close
  end

  # TODO: start playing from correct frame (from paused frame)
  def resume
    @is_runnable = true
  end

  def play_loop
    @thread = Thread.new do
      loop do
        run_sample if @is_runnable
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

  def run_sample(start_frame=0, end_frame=1000000000)
    input_stream = FileInputStream.new(@file)
    @jmp = Java::JavazoomJlPlayerAdvanced::AdvancedPlayer.new(input_stream)
    @jmp.setPlayBackListener(@pbl)
    @jmp.play(start_frame, end_frame)
    sleep 0.5
  end

end
