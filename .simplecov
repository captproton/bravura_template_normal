# .simplecov

SimpleCov.start 'rails' do
  enable_coverage :branch

  # Filters
  add_filter %r{^/spec/}
  add_filter %r{^/test/}
  add_filter %r{^/config/}
  add_filter %r{^/lib/}
  add_filter %r{^/vendor/}
  add_filter %r{^/spec/dummy/}  # Ignore the dummy app

  # Groups
  add_group 'Controllers', 'app/controllers'
  add_group 'Models', 'app/models'
  add_group 'Helpers', 'app/helpers'
  add_group 'Mailers', 'app/mailers'
  add_group 'Views', 'app/views'
  add_group 'Libraries', 'lib'
  add_group 'Javascripts', 'app/javascript'  # Updated for Rails 7.1
  add_group 'Stylesheets', 'app/assets/stylesheets'  # Updated for Rails 7.1

  # Engine-specific directories
  add_group 'Engine', 'lib/bravura_template_normal'  # Adjust this to your engine name

  # Track files inside the engine's app directory
  track_files "#{SimpleCov.root}/app/**/*.rb"
  track_files "#{SimpleCov.root}/lib/**/*.rb"

  # Ignore certain patterns
  add_filter do |source_file|
    source_file.lines.count < 5
  end
end

SimpleCov.minimum_coverage 90
SimpleCov.maximum_coverage_drop 5

# Use different formatters for local vs CI environments
if ENV['CI']
  require 'simplecov-cobertura'
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
else
  SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
end

# Merge coverage from multiple test suites if applicable
SimpleCov.use_merging true
SimpleCov.merge_timeout 3600
