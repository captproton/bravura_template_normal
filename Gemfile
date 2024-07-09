source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in bravura_template_normal.gemspec.
gemspec

gem "puma"

gem "sqlite3"

gem "sprockets-rails"

# Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
gem "rubocop-rails-omakase", require: false

group :development do
end

# Include bravura_template_base from git
gem 'bravura_template_base', github: 'captproton/bravura_template_base', branch: 'main'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'brakeman', require: false

end

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
