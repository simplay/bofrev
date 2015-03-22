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
  #
  # @param type_name [Symbol] class name as down-cased symbol.
  def notify_all_targets_of_type(type_name)
    observers_of_type(type_name).each &:handle_event
  end

  # Append a new observer to the observers list.
  #
  # @param observer [Observer] listener of events thrown by this Observable.
  def subscribe(observer)
    @observers << observer
  end

  # Remove all observers of type :type_name from the observer list.
  #
  # @param type_name [Symbol] class name as down-cased symbol.
  # @hint: These observers will not get notified anymore.
  def unsubscribe(type_name)
    observers_of_type(type_name).each do |observer|
      observer.perform_gui_close_steps
      unsubscribe_one(observer)
    end
  end

  # Removes a given observer from from the observer list.
  #
  # @param observer [Observer] listener of events thrown by this Observable.
  def unsubscribe_one(observer)
    @observers.delete(observer)
  end

  # Select all observers of a specified type.
  #
  # @hint: type_name is down-cased symbol representation of observer's class.
  # @param type_name [Symbol] class name as down-cased symbol.
  def observers_of_type(type_name)
    @observers.select do |observer|
      observer.class.to_s.downcase == type_name.to_s
    end
  end

end