#if ENV['COVERAGE']
 # require 'simplecov'
 # SimpleCov.start do
 #   add_filter 'test'
 #   command_name 'test'
 # end
#end

ENV["RAILS_ENV"] = "test"

require 'minitest/autorun'
