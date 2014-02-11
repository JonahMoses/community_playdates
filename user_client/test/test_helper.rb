require 'simplecov'
SimpleCov.start 'rails'
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"
require 'vcr'
require 'webmock'
require 'minitest/autorun'
require 'minitest/pride'

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # VCR is used to 'record' HTTP interactions with
  # third party services used in tests, and play em
  # back. Useful for efficiency, also useful for
  # testing code against API's that not everyone
  # has access to -- the responses can be cached
  # and re-used.

  # To allow us to do real HTTP requests in a VCR.turned_off, we
  # have to tell webmock to let us.
  WebMock.allow_net_connect!

  VCR.configure do |c|
    c.cassette_library_dir = 'test/vcr_cassettes'
    # webmock needed for HTTPClient testing
    c.hook_into :webmock
  end

  # Silly way to not have to rewrite all our tests if we
  # temporarily disable VCR, make VCR.use_cassette a no-op
  # instead of no-such-method.
  if ! defined? VCR

    module VCR

      def self.use_cassette(*args)
        yield
      end

    end

  end

end

