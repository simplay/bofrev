require 'observable'
require 'observer'

class Adapter < Observer
  include Observable

  def initialize(channel)
    @channel = channel
    channel.subscribe(self)
    self.subscribe(channel)
  end
  # handle an event thrown by observed Observable.
  def handle_event
    raise "not implemented yet"
  end

  # @param message [Symbol] type of message.
  def handle_event_with(message)
    raise "not implemented yet"
  end
end
