#if ENV['COVERAGE']
 # require 'simplecov'
 # SimpleCov.start do
 #   add_filter 'test'
 #   command_name 'test'
 # end
#end
require "codeclimate-test-reporter"
require 'coveralls'
Coveralls.wear!
#CodeClimate::TestReporter.configure do |config|
#  config.path_prefix = "../src/"
#end 
CodeClimate::TestReporter.start

require 'simplecov'
require 'minitest/autorun'
