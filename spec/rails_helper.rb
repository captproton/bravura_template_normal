# spec/rails_helper.rb
# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative 'dummy/config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'faker'
require 'factory_bot_rails'

# Load support files
Dir[BravuraTemplateNormal::Engine.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

# Configure FactoryBot
FactoryBot.definition_file_paths << BravuraTemplateNormal::Engine.root.join('spec', 'factories')
FactoryBot.find_definitions

RSpec.configure do |config|
  config.fixture_paths = [BravuraTemplateNormal::Engine.root.join('spec', 'fixtures')]
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # Include FactoryBot methods
  config.include FactoryBot::Syntax::Methods

  # Include engine routes in tests
  config.include BravuraTemplateNormal::Engine.routes.url_helpers

  # Include the dummy app's routes in tests
  config.include Rails.application.routes.url_helpers

  # Include CurrentStub in all tests
  config.include CurrentStub

  # Database Cleaner configuration
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end

  # Configure Shoulda Matchers
  Shoulda::Matchers.configure do |shoulda_config|
    shoulda_config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end

  # Ensure that if we are running js tests, we are using latest webpack assets
  # This will use the defaults of :js and :server_rendering meta tags
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, :js, type: :system) do
    driven_by :selenium_chrome_headless
  end
end

# Set default url options for the test environment
Rails.application.routes.default_url_options[:host] = 'test.host'

# Clear FactoryBot definitions before running tests
FactoryBot.factories.clear
FactoryBot.find_definitions
