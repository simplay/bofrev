require 'singletonable'

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

end
