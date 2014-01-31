require File.expand_path("../../config/environment", __FILE__)
require 'spork'
require 'shoulda-matchers'
require 'capybara/rspec'
require 'capybara/rails'
require 'rspec/rails'
require 'rspec/autorun'
require 'database_cleaner'
require 'factory_girl'
require 'faker'

def setup_environment
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'

  ENV['DRB'] = 'true'
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  Rails.backtrace_cleaner.remove_silencers!

  DatabaseCleaner.strategy = :transaction

  RSpec.configure do |config|
    
    Warden.test_mode!

    config.use_transactional_fixtures = false
    
    config.before(:suite) do
      DatabaseCleaner.clean_with(:transaction)
    end

    # Use transactions by default
    config.before :each do
      DatabaseCleaner.strategy = :transaction
    end
    
    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after :each do
      DatabaseCleaner.clean
    end

    config.mock_with :rspec

    config.after(:each) do
      Warden.test_reset!
    end

    config.include Rails.application.routes.url_helpers
    config.include Devise::TestHelpers, :type => :controller
    config.include Warden::Test::Helpers
    config.include FactoryGirl::Syntax::Methods
  end
end

def each_run
  ActiveSupport::Dependencies.clear
  FactoryGirl.reload

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
end

# If spork is available in the Gemfile it'll be used but we don't force it.
Spork.prefork do
  setup_environment
end

Spork.each_run do
  each_run
end