# frozen_string_literal: true

require_relative 'lib/bravura_template_normal/version'

Gem::Specification.new do |spec|
  spec.name = 'bravura_template_normal'
  spec.version = BravuraTemplateNormal::VERSION
  spec.authors = ['captproton']
  spec.email = ['carl@wdwhub.net']
  spec.homepage = 'https://github.com/captproton/bravura_template_product_updates'
  spec.summary = 'The default template for the Bravura platform.'
  spec.description = 'BravuraTemplateNormal provides the default layout for the Bravura platform.'
  spec.license = 'MIT'

  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/captproton/bravura_template_normal'
  spec.metadata['changelog_uri'] = 'https://github.com/captproton/bravura_template_normal/blob/main/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  spec.add_dependency 'bravura_template_base', '>= 0.1', '< 0.4'
  spec.add_dependency 'jsbundling-rails', '~> 1.2.1'
  spec.add_development_dependency 'esbuild-rails', '~> 0.1.4' # rubocop:disable Gemspec/DevelopmentDependencies
  spec.add_dependency 'rails', '>= 7.1', '< 7.3'

  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify the required Ruby version for this gem
  spec.required_ruby_version = '>= 3.2.0'
end
