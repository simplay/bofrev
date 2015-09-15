require "test_helper"
require 'stringio'

class TestColor < Minitest::Test

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

  def test_handle_event
    app = Application.new({})
    out = fetch_stdout {app.handle_event}
    assert_equal(out.strip, "GAME OVER")
  end

end
