# frozen_string_literal: true

# lib/bravura_template_normal/engine.rb
require 'bravura_template_base'

module BravuraTemplateNormal
  # Engine class for the BravuraTemplateNormal module.
  # This class isolates the namespace of the module and sets up necessary configurations,
  # including view paths, helpers, and template-specific settings.
  class Engine < ::Rails::Engine
    isolate_namespace BravuraTemplateNormal

    # Configuration options
    mattr_accessor :header_style
    self.header_style = 'default'

    # In Rails 7.1, we don't need to explicitly precompile assets in most cases
    # The asset pipeline will automatically pick up assets in the app/assets directory

    # Add template-specific view paths
    initializer 'bravura_template_normal.add_view_paths' do
      ActiveSupport.on_load(:action_controller) do
        append_view_path Engine.root.join('app', 'views', 'bravura_template_normal')
      end
    end

    # Include template-specific helpers
    initializer 'bravura_template_normal.helpers' do
      ActiveSupport.on_load(:action_controller) do
        helper BravuraTemplateNormal::ApplicationHelper
      end
    end

    # Set up any template-specific configurations
    initializer 'bravura_template_normal.configure' do |app|
      # You can access the main app's configuration here if needed
      if app.config.respond_to?(:bravura_template_base)
        self.header_style = app.config.bravura_template_base.default_header_style
      end
    end
  end
end
