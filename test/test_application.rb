require "test_helper"
require 'stringio'
require 'observer'

class TestApplication < Minitest::Test

  # allow to fetch puts outputs
  def fetch_stdout(&block)
    begin
      old_stdout = $stdout
      $stdout = StringIO.new('','w')
      yield block
      $stdout.string
    ensure
      $stdout = old_stdout
    end
  end

  # overwridden View class initializer to not spawn a atw frame.
  View.class_eval do
    def initialize(game)
    end
  end

  Server.class_eval do
    def initialize
      puts "server is running"
    end
  end

  Client.class_eval do
    def initialize
      puts "client is running"
    end
  end

  def test_handle_event
    app = Application.new({})
    out = fetch_stdout {app.handle_event}
    assert_equal(out.strip, "GAME OVER")
  end

  def test_iniialize
    app = Application.new({})
    assert(app.kind_of?(Observer))
  end

  def test_initialize_run_client_case
    out = fetch_stdout {Application.new({:multiplayer => 1})}
    assert_equal(out.strip, "client is running")
  end

  def test_initialize_run_server_case
    out = fetch_stdout {Application.new({:multiplayer => 2})}
    assert_equal(out.strip, "server is running")
  end

end
