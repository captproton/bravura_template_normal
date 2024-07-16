# app/controllers/bravura_template_normal/application_controller.rb

module BravuraTemplateNormal
  class ApplicationController < ::ApplicationController
    include Rails.application.routes.url_helpers
    helper_method :current_account, :current_account_site_mode, :all_settings, :favicon_url

    private

    def current_account
      @current_account ||= begin
        super
      rescue StandardError
        nil
      end
    end

    def current_account_site_mode
      all_settings[:design]&.site_mode&.name&.downcase == 'dark' ? 'dark-mode' : 'light-mode'
    end

    def all_settings
      @all_settings ||= BravuraTemplateNormal::Engine.config.bravura_template_normal.settings_provider.call
    end

    def favicon_url
      if all_settings[:general]&.favicon&.attached?
        rails_blob_url(all_settings[:general].favicon)
      else
        asset_path('default_favicon.png')
      end
    end
  end
end
