# frozen_string_literal: true

module BravuraTemplateNormal
  # ApplicationController for BravuraTemplateNormal
  # Handles common functionality and settings for the template
  class ApplicationController < ::ApplicationController
    include Rails.application.routes.url_helpers
    helper BravuraTemplateNormal::ApplicationHelper
    helper_method :all_settings, :current_account_site_mode, :favicon_url

    before_action :debug_settings

    private

    def current_account
      @current_account ||= begin
        super
      rescue StandardError => e
        Rails.logger.error "Error fetching current_account: #{e.message}"
        nil
      end
    end

    def current_account_site_mode
      (all_settings[:design]&.site_mode&.site_theme&.downcase || 'system').to_s
    end

    def all_settings
      @all_settings ||= begin
        settings = BravuraTemplateNormal::Engine.config.bravura_template_normal.settings_provider.call
        Rails.logger.debug { "All settings: #{settings.inspect}" }
        settings
      rescue StandardError => e
        Rails.logger.error "Error fetching settings: #{e.message}"
        {}
      end
    end

    def favicon_url
      if all_settings[:general]&.favicon&.attached?
        rails_blob_url(all_settings[:general].favicon)
      else
        asset_path('default_favicon.png')
      end
    end

    def debug_settings
      Rails.logger.debug { "Current account site mode: #{current_account_site_mode}" }
      Rails.logger.debug { "All settings: #{all_settings.inspect}" }
    end

    def method_missing(method, *, &)
      if main_app.respond_to?(method)
        main_app.send(method, *, &)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      main_app.respond_to?(method) || super
    end
  end
end
