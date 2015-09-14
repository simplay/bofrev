#if ENV['COVERAGE']
 # require 'simplecov'
 # SimpleCov.start do
 #   add_filter 'test'
 #   command_name 'test'
 # end
#end

require 'simplecov'
require 'minitest/autorun'
