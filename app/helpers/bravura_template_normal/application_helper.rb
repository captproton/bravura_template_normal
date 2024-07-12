# frozen_string_literal: true

# Provides helper methods for the BravuraTemplateNormal application
module BravuraTemplateNormal
  # Helper methods for application views
  module ApplicationHelper
    def favicon_url
      general_settings = Settings::General.cached(Current.account.id)
      if general_settings&.favicon&.attached?
        rails_blob_url(general_settings.favicon)
      else
        asset_path('default_favicon.png')
      end
    end

    def social_links
      Settings::General.cached(Current.account.id)&.platform_links || {}
    end
  end
end
