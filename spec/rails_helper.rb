# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('dummy/config/environment', __dir__)
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

  # Include UrlHelpers in system tests
  config.include UrlHelpers, type: :system

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

  # Configure system tests
  config.before(:each, type: :system) do
    driven_by :rack_test

    # Configure asset compilation for test environment
    Rails.application.config.assets.compile = true
    Rails.application.config.assets.digest = false

    # Stub ActionView::Base methods
    allow(ActionView::Base).to receive(:new).and_wrap_original do |original_method, *args|
      instance = original_method.call(*args)
      allow(instance).to receive(:asset_path) do |asset|
        "/assets/#{asset}"
      end
      allow(instance).to receive(:image_tag).and_return(
        '<img src="/assets/default_logo.png" alt="Default Logo" class="h-8 w-auto mr-1">'
      )
      instance
    end

    # Ensure the engine's view paths are included
    ActionController::Base.prepend_view_path(BravuraTemplateNormal::Engine.root.join('app', 'views'))
  end

  config.before(:each, :js, type: :system) do
    driven_by :selenium_chrome_headless
  end

  # Include the ViewRendering module
  config.include RSpec::Rails::ViewRendering

  # Include custom files in the RSpec configuration
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
  config.include SystemSpecHelper, type: :system
end

# Set default url options for the test environment
Rails.application.routes.default_url_options[:host] = 'test.host'

# Clear FactoryBot definitions before running tests
FactoryBot.factories.clear
FactoryBot.find_definitions
