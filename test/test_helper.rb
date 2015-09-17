# necessary requirements for code coverage and reporting its rate.
require "codeclimate-test-reporter"
require 'coveralls'

# report coverage (Coveralls.wear! helps us to transmit correct coverage to CodeClimate)
Coveralls.wear!
CodeClimate::TestReporter.start

# necessary requirements for for minitest
require 'simplecov'
require 'minitest/autorun'
require 'class_adaptions'
include ClassAdaptions
