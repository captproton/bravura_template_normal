require_relative "lib/bravura_template_normal/version"

Gem::Specification.new do |spec|
  spec.name = "bravura_template_normal"
  spec.version = BravuraTemplateNormal::VERSION
  spec.authors = [ "captproton" ]
  spec.email = [ "carl@wdwhub.net" ]
  spec.homepage = "https://github.com/captproton/bravura_template_product_updates"
  spec.summary = "The default template for the Bravura platform."
  spec.description = "BravuraTemplateNormal provides the default layout for the Bravura platform."
  spec.license = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/captproton/bravura_template_normal"
  spec.metadata["changelog_uri"] = "https://github.com/captproton/bravura_template_normal/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1", "< 7.3"
  spec.add_dependency "bravura_template_base", "~> 0.1.0"

  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "factory_bot_rails"
  spec.add_development_dependency "capybara"
  spec.add_development_dependency "database_cleaner-active_record"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "webmock"
end
