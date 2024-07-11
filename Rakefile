# Rakefile
# frozen_string_literal: true

require 'bundler/setup'

APP_RAKEFILE = File.expand_path('spec/dummy/Rakefile', __dir__)
load 'rails/tasks/engine.rake'
load 'rails/tasks/statistics.rake'
require 'bundler/gem_tasks'

namespace :assets do
  desc 'Build JavaScript assets'
  task build: :environment do
    sh 'yarn build'
  end
end

Rake::Task['assets:precompile'].enhance(['assets:build']) if Rake::Task.task_defined?('assets:precompile')
