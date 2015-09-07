require 'thread'

# A class including the waitable module is representing a shared resource among several threads
# that can only be consumed if and only if certain conditions hold true.
# In case those conditions are not satisfied, the resource blocks, i.e. threads
# that want to consume the resource are put into a waiting state.
# Remember that waiting is not the same as a busy waiting loop. rather a thread is put to
# a suspended state and will be rewoken again only after
# being signaled by the resource holder or a produce..
module Waitable

  module Initializer

    def initialize(*params)
      @clients = []
      @mutex = Mutex.new
      @resource = ConditionVariable.new
      @is_suspended = false
      super(*params)
    end

  end

  def self.included(klass)
    klass.send(:prepend, Initializer)
  end

  # Append a client waiting for this mutex' resource.
  #
  # @hint: Each client is supposed to implement the following methods:
  #   :pause: halt this client (thread).
  #   :resume: resume this client (thread).
  # Clients are usually Thread objects.
  def append_waitable(client)
    @clients << client
  end

  # Returns the mutex for this Waitable instance.
  #
  # @hint: Can be used to have synchronized/offer mutal exclusive accesses
  # locking on this Waitable.
  #
  # @example:
  # class Counter
  #   include Waitable
  #   ...
  #   def increment
  #     self.mutex.synchronize do
  #       value = value++
  #     end
  #   end
  #   ...
  # end
  #
  # @return [Mutex] mutex of this Waitable.
  # Models a lock used for mutual exclusive operations.
  def mutex
    @mutex
  end

  # Returns the conditional conditional variable for this Waitable instance.
  #
  # @hint: can be used to wait/signal on this waitable.
  # Do not forget locking via the mutex.
  #
  # @example:
  #
  # class Ticker
  # ...
  # def suspend
  #   @game.mutex.synchronize do
  #     @game.barrier.wait(@game.mutex)
  #   end
  # end
  # ...
  # end
  #
  # @return [ConditionVariable] conditional variable of this waitable.
  def barrier
    @resource

  end

  # Suspend this Waitable. Suspends all clients threads.
  def pause
    @mutex.synchronize do
      @is_suspended = true
      @clients.each &:suspend
    end
  end

  # Is this Waitbale suspended?
  # When a Waitable is paused, all of the game related threads are supposed
  # to be suspended as well.
  # @return [Boolean] true if Waitable is suspended otherwise false.
  def paused?
    @mutex.synchronize do
      @is_suspended
    end
  end

  # Resume this Waitable. Resumes all Waitable client threads.
  def resume
    @mutex.synchronize do
      @is_suspended = false
      @clients.each &:resume
      @resource.signal
    end
  end

end
