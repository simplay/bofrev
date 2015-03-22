# Each Observer is supposed to implement #handle_event
module Observable

  # Define a new list of Observers
  module Initializer
    def initialize
      @observers = []
      super
    end
  end

  def self.included(klass)
    klass.send(:prepend, Initializer)
  end

  # Inform all observers that they should handle an occurred event.
  def notify_all
    @observers.each &:handle_event
  end

  # Inform all selected observers that they should handle an occurred event.
  # @param type_name [Symbol] class name as down-cased symbol.
  def notify_all_targets_of_type(type_name)
    selected_observers = @observers.select do |observer| observer.class.to_s == type_name.to_s end
    selected_observers.each &:handle_event
  end

  # Append a new observer to the observers list.
  # @param observer [Observer] listener of events thrown by this Observable.
  def subscribe(observer)
    @observers << observer
  end

end