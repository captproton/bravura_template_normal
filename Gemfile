# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in bravura_template_normal.gemspec.
gemspec

gem 'puma'

gem 'sqlite3'

gem 'sprockets-rails'

# Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
gem 'rubocop-rails-omakase', require: false

# Include bravura_template_base from git
gem 'bravura_template_base', github: 'captproton/bravura_template_base', branch: 'main'

group :development, :test do
  gem 'brakeman', require: false
  gem 'capybara'
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'rubocop-standard', require: false
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'standard'
  gem 'webmock'
  # rubocop recommendations
  gem 'rubocop-capybara', '~> 2.21', require: false
  gem 'rubocop-factory_bot', '~> 2.26', '>= 2.26.1', require: false
  gem 'rubocop-rspec', '~> 3.1', require: false
end
# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"

gem 'rubocop-rspec_rails', '~> 2.30'
