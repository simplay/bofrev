# A Observer is used to handle asynchronous events.
# Every Observer is subscribed to a Observable instance.
# When its Observable calls #notify_all
# then Observer#handle_event is triggered.
# When its Observable calls #notify_all_with_message
# then Observer#handle_event_with is triggered.
class Observer

  # Handle a notification containing a message
  # received by this Observer's Observable instance.
  #
  # @hint: A notification via Observable#notify_all
  #   triggers this handle.
  #   By default, calling this method throws an exception when not implemented.
  def handle_event
    raise "not implemented yet"
  end

  # Handle a notification containing a message
  # received by this Observer's Observable instance.
  #
  # @hint: A notification via Observable#notify_all_with_message
  #   triggers this handle.
  #   By default, calling this method throws an exception when not implemented.
  # @param message [Symbol, Event] type of message.
  def handle_event_with(message)
    raise "not implemented yet"
  end

end
