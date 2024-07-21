# frozen_string_literal: true

# lib/bravura_template_normal/engine.rb

require 'bravura_template_base'
require 'inline_svg'

module BravuraTemplateNormal
  # Engine class for the BravuraTemplateNormal module.
  # This class isolates the namespace of the module and sets up necessary configurations,
  # including view paths, helpers, and template-specific settings.
  class Engine < ::Rails::Engine
    isolate_namespace BravuraTemplateNormal

    # Configuration options
    mattr_accessor :header_style
    self.header_style = 'default'

    # Initializes the BravuraTemplateNormal engine by extending ActionController to include the ApplicationHelper.
    # This ensures that ApplicationHelper's methods are available in all controllers and views,
    # providing a consistent set of helper methods across the application.
    initializer 'bravura_template_normal.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper ::ApplicationHelper
      end
    end

    # Settings provider configuration
    config.bravura_template_normal = ActiveSupport::OrderedOptions.new
    config.bravura_template_normal.settings_provider = -> { SettingsService.for_account(Current.account) }

    # Add template-specific view paths
    initializer 'bravura_template_normal.add_view_paths' do
      ActiveSupport.on_load(:action_controller) do
        append_view_path Engine.root.join('app', 'views', 'bravura_template_normal')
      end
    end

    # Initializes the BravuraTemplateNormal engine by extending ActionController to include the ApplicationHelper.
    # This ensures that ApplicationHelper's methods are available in all controllers and views, providing a consistent set of helper methods across the application.
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

    # Asset configuration
    initializer 'bravura_template_normal.assets' do |app|
      app.config.assets.precompile += %w[
        bravura_template_normal/application.js
        bravura_template_normal/application.tailwind.css
        bravura_template_normal/default_logo.png
      ]
      app.config.assets.paths << root.join('app/assets/builds/bravura_template_normal')
      app.config.assets.paths << root.join('app', 'assets', 'stylesheets')
      app.config.assets.paths << root.join('app', 'assets', 'javascripts')
    end

    initializer 'bravura_template_normal.register_template' do
      BravuraTemplateBase.register_template('bravura_template_normal')
    end
  end
end
