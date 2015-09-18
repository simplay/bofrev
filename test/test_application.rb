require "test_helper"
require 'stringio'
require 'observer'

class TestApplication < Minitest::Test

  def test_handle_event
    app = Application.new({})
    out = fetch_stdout {app.handle_event}
    assert_equal(out.strip.include?("GAME OVER"), true)
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
