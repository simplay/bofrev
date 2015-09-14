# An Event represents a certain type of message having a type and an optional content.
# Events are used to model certain triggered messages, susch as game state updates including
# the update values.
class Event

  attr_reader :type, :content

  # @param type [Symbol] some identifying message type.
  # @param content [String, Integer, Hash] content of message.
  #   is optional, by default it is nil.
  def initialize(type, content=nil)
    @type = type
    @content = content
  end

  # @return [String] pretty string representation of Event.
  def to_s
    "type: #{type} content: #{content}"
  end
end
