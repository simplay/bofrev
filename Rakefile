task :default => :test
task :test do
  require 'java'
  $LOAD_PATH.unshift File.expand_path("src")
  $LOAD_PATH.unshift File.expand_path("test")
  require 'application'
  Dir.glob('test/test_*.rb').each do |file|
    unless file.include?("test_helper.rb")
      require file.split("/").last
      require file.split(/test_/).last
    end
  end
end

namespace :test do
  task :coverage do
    #require 'simplecov'
    #SimpleCov.start
    Rake::Task["test"].execute
  end
end
