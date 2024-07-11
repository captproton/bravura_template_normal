# frozen_string_literal: true

# desc "Explaining what the task does"
# task :bravura_template_normal do
#   # Task goes here
# end

namespace :bravura_template_normal do
  namespace :assets do
    desc 'Build JavaScript assets'
    task build: :environment do
      system 'yarn build'
    end
  end
end

if Rake::Task.task_defined?('assets:precompile')
  Rake::Task['assets:precompile'].enhance(['bravura_template_normal:assets:build'])
end
