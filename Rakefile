task :default => :test
task :test do
  require 'java'
  $LOAD_PATH.unshift File.expand_path("src")
  require 'application'
  Dir.glob('test/test_*.rb').each { |file| require file; require file.split(/test_/).last}
  require 'coveralls'
  Coveralls.wear!
end
