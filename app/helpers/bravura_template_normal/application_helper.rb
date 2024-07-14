# frozen_string_literal: true

# app/helpers/bravura_template_normal/application_helper.rb

# Provides view helper methods that span across all public-facing pages for the BravuraTemplateNormal engine
module BravuraTemplateNormal
  # ApplicationHelper contains helper methods for use across the BravuraTemplateNormal engine.
  # These methods assist in rendering common elements such as favicons and social links.
  module ApplicationHelper
    def favicon_url
      general_settings = Current.account.settings_general
      if general_settings&.favicon&.attached?
        rails_blob_url(general_settings.favicon)
      else
        asset_path('default_favicon.png')
      end
    end

    def social_links
      general_settings = Current.account.settings_general
      general_settings&.platform_links || {}
    end
  end
end
