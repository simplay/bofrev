require "test_helper"

class TestSystemInformation < Minitest::Test

  # Runs before every test, before teardown.
  # Flush SystemInformation singleton before running a SystemInformation test.
  def before_teardown
    SystemInformation.build
  end

  def test_running_on_os_methods_windows_case
    SystemInformation.build.set_os("windows")
    assert_equal(SystemInformation.running_on_windows?, true)
    assert_equal(SystemInformation.running_on_mac?, false)
    assert_equal(SystemInformation.running_on_linux?, false)
  end

  def test_running_on_os_methods_mac_case
    SystemInformation.build.set_os("mac")
    assert_equal(SystemInformation.running_on_windows?, false)
    assert_equal(SystemInformation.running_on_mac?, true)
    assert_equal(SystemInformation.running_on_linux?, false)
  end

  def test_running_on_os_methods_linux_case
    SystemInformation.build.set_os("linux")
    assert_equal(SystemInformation.running_on_windows?, false)
    assert_equal(SystemInformation.running_on_mac?, false)
    assert_equal(SystemInformation.running_on_linux?, true)
  end

  def test_called_by_caller_methods_console_case
    SystemInformation.build.set_caller("console")
    assert_equal(SystemInformation.called_by_console?, true)
    assert_equal(SystemInformation.called_by_jar?, false)
  end

  def test_called_by_caller_methods_jar_case
    SystemInformation.build.set_caller("jar")
    assert_equal(SystemInformation.called_by_console?, false)
    assert_equal(SystemInformation.called_by_jar?, true)
  end

end
