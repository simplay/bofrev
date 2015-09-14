#if ENV['COVERAGE']
 # require 'simplecov'
 # SimpleCov.start do
 #   add_filter 'test'
 #   command_name 'test'
 # end
#end
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'simplecov'
require 'minitest/autorun'
