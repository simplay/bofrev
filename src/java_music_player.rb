require 'java'
java_import "java.io.FileInputStream"

require_relative '../lib/tinysound-1.1.1/tinysound-1.1.1.jar'
java_import 'kuusisto.tinysound.Music'
java_import 'kuusisto.tinysound.Sound'
java_import 'kuusisto.tinysound.TinySound'

class JavaMusicPlayer


  def initialize(file)
    @file = file
    @is_runnable = true
    TinySound.init
  end

  def pause
    @is_runnable = false
    @audio_file.pause
  end

  def resume
    @audio_file.resume
    @is_runnable = true
  end

  def play_loop
    @thread = Thread.new do
      run_sample(:loop)
    end
  end

  def play
    @thread = Thread.new do
      run_sample(:once)
    end
  end

  def stop
    @audio_file.stop
  end

  def shut_down
    TinySound.shutdown
  end

  protected

  def run_sample(type)
    if type == :loop
      @audio_file = TinySound.loadMusic(@file)
      @audio_file.play(true)
    else
      @audio_file = TinySound.loadSound(@file)
      @audio_file.play
    end
    sleep 0.5
  end

end
