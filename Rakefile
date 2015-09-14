require 'simplecov'
SimpleCov.start
SimpleCov.root "test/"

task :default => :test
task :test do
  #JRUBY_OPTS="-Xcli.debug=true --debug"
#if ENV['COVERAGE']
  require 'pry'
#end
#  require 'simplecov'
#  SimpleCov.start

  require 'java'
  $LOAD_PATH.unshift File.expand_path("src")
  $LOAD_PATH.unshift File.expand_path("test")
  #ENV["JRUBY_OPTS"] = "-Xcli.debug=true --debug"
  require 'application'
  Dir.glob('test/test_*.rb').each do |file|
    unless file.include?("test_helper.rb")
      require file.split("/").last
      require file.split(/test_/).last
    end
  end
end
