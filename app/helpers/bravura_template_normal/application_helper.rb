# frozen_string_literal: true

# app/helpers/bravura_template_normal/application_helper.rb

# Provides view helper methods that span across all public-facing pages for the BravuraTemplateNormal engine
module BravuraTemplateNormal
  # ApplicationHelper contains helper methods for use across the BravuraTemplateNormal engine.
  # It includes methods for fetching favicon URLs and social platform links based on account settings.
  module ApplicationHelper
    # Returns the URL for the favicon based on the current account's settings
    # or a default favicon if none is attached.
    def favicon_url
      general_settings = BravuraTemplateNormal::Settings::General.find_by(account_id: Current.account.id)
      if general_settings&.favicon&.attached?
        rails_blob_url(general_settings.favicon)
      else
        asset_path('default_favicon.png')
      end
    end

    # Returns a hash of social platform links based on the current account's settings.
    def social_links
      general_settings = BravuraTemplateNormal::Settings::General.find_by(account_id: Current.account.id)
      general_settings&.platform_links || {}
    end
  end
end
