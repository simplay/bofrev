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
  #   :pause
  #   :resume
  def append_waitable(client)
    @clients << client
  end

  def mutex
    @mutex
  end

  def cond_var
    @resource
  end

  # Suspend this game. Suspends all game threads.
  def pause
    @mutex.synchronize do
      @is_suspended = true
      @clients.each &:suspend
    end
  end

  # Is this game suspended?
  # When a game is paused, all of the game related threads are supposed to be suspended as well.
  # @return [Boolean] true if game is suspended otherwise false.
  def paused?
    @mutex.synchronize do
      @is_suspended
    end
  end

  # Resume this game. Resumes all game threads.
  def resume
    @mutex.synchronize do
      @is_suspended = false
      @clients.each &:resume
      @resource.signal
    end
  end

end
