task :default => :test
task :test do
  $LOAD_PATH.unshift File.expand_path("./src")
  Dir.glob('./test/test_*.rb').each { |file| require file}
end
