# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.before :suite do
    DatabaseCleaner.strategy = :truncation
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
    :provider => 'facebook',
    :uid => '12345',
    :info => {
      :nickname => 'bhorne',
      :email => 'ben@horne.com',
      :name => 'Ben Horne',
      :first_name => 'Ben',
      :last_name => 'Horne',
      :image => 'http://graph.facebook.com/1234567/picture?type=square',
      :urls => { :Facebook => 'http://www.facebook.com/jbloggs' },
      :location => 'Denver, Colorado',
      :verified => true
      },
    :credentials => {
      :token => 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
      :expires_at => 1521747205, # when the access token expires (it always will)
      :expires => true # this will always be true
      },
    :extra => {
      :raw_info => {
        :id => '1234567',
        :name => 'Ben Horne',
        :first_name => 'Ben',
        :last_name => 'Horne',
        :link => 'http://www.facebook.com/benhorne44',
        :username => 'benhorne',
        :location => { :id => '123456789', :name => 'Denver, Colorado' },
        :gender => 'male',
        :email => 'ben@horne.com',
        :timezone => -8,
        :locale => 'en_US',
        :verified => true,
        :updated_time => '2011-11-11T06:21:03+0000'
        }
      }
    })
end

def login
  Koala::Facebook::API.any_instance.stub(:get_picture).and_return('/')
  visit root_path
  click_on "Sign in with Facebook"
end

