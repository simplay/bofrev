require 'java'
java_import 'java.lang.System'

# SystemInformation provides runtime information such as on which os bofrev is running
# or by whom it is called (either from the console or by an exectuable jar).
# This kind of system information will be used to handle os/system specific circumstances
# that affect the runtime behaviour of bofrev. For example, on windows there is a different
# offset for the canvas required (since unit pixels seem be differently sized than on other os).
# Another example is the case when bofrev is called by its exectuable jar.
# Then the whole pathing has to be differently handled (otherwise music/image files
# will not be loaded correctly). This is due to the fact that
# the jar has a different file hierarchy.
class SystemInformation

  attr_reader :os, :caller

  CALLER_JAR = 'jar'
  CALLER_CONSOLE = 'console'

  def self.running_on_mac?
    build.os.include?('mac')
  end

  def self.running_on_windows?
    build.os.include?('windows')
  end

  def self.running_on_linux?
    build.os.include?('linux')
  end

  def self.called_by_jar?
    build.caller == CALLER_JAR
  end

  def self.called_by_console?
    build.caller == CALLER_CONSOLE
  end

  private

  def self.build
    return @system_information unless @system_information.nil?
    @system_information = SystemInformation.new
  end

  def initialize
    caller_name = "#{$PROGRAM_NAME}"
    @caller = caller_name.include?("<script>") ? CALLER_JAR : CALLER_CONSOLE
    @os = System.getProperty("os.name").downcase
  end

end
