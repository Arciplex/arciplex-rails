ENV["RAILS_ENV"] = 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'shoulda-matchers'
require 'capybara/rspec'
require 'capybara/rails'
require 'rspec/rails'
require 'database_cleaner'
require 'faker'

def setup_environment

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
    config.include Devise::TestHelpers, type: :controller
    config.include Warden::Test::Helpers
    config.include FactoryGirl::Syntax::Methods
  end
end

prefork = lambda {
  setup_environment
}

each_run = lambda {
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
  # FactoryGirl.reload
}

# If Zeus is available it'll be used but we don't force it.
if defined?(Zeus)
  prefork.call
  $each_run = each_run
  class << Zeus.plan
    def after_fork_with_test
      after_fork_without_test
      $each_run.call
    end
    alias_method_chain :after_fork, :test
  end
else
  prefork.call
  each_run.call
end
