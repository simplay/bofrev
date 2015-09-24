require 'singletonable'
require 'java'
java_import 'javax.swing.SwingUtilities'

# Utility is a Singleton that contains common shared functionality and utility methods.
class Utility

  extend Singletonable

  # Normalizes a given String.
  # preserve and handle all potential underscore class name cases.
  #
  # @info: method has been taken from Rail's String core extension.
  #
  # @example:
  #   word = "FooBar"
  #   underscore(word) #=> "foo_bar"
  #
  #   word = "Base::FooBar"
  #   underscore(word) #=> "base/foo_bar"
  #
  # @hint: Normalizing means to remove namespaces, downcasing
  #   and trimming previousely upcased words by a '_'.
  #   Namespaces are interpreted as fiepaths.
  # @param word [String] word to normalize
  # @return [String] normalized word
  def self.underscore(word)
    word = word.dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end

  # Keep the the application running, until the the AWT's event thread has been terminated.
  # This is achieved by joining the event thread at this location.
  # This method is only used when running bofrev via an executable jar.
  #
  # @note: without calling this method at the very end of the application,
  #   the JFrame window shows up and instantly closes.
  #
  # @info: Warbler calls System.exit() after your main script exits.
  #   This causes the Swing EventThread to exit, closing your app.
  #   See: https://github.com/jruby/warbler/blob/master/ext/JarMain.java#L131
  def self.keep_running_until_interrupt
    if SystemInformation.called_by_jar?
      event_thread = nil
      SwingUtilities.invokeAndWait { event_thread = java.lang.Thread.currentThread }
      event_thread.join
    end
  end

end
