# frozen_string_literal: true

module BravuraTemplateNormal
  # SettingsHelper provides methods to access and interpret various settings
  # for the BravuraTemplateNormal engine
  module SettingsHelper
    def all_settings
      @all_settings ||= BravuraTemplateNormal::Engine.config.bravura_template_normal.settings_provider.call
    end

    def publication_name
      all_settings[:general]&.publication_name
    end

    def dark_mode?
      all_settings[:design]&.site_mode&.name == 'Dark'
    end

    def footer_copyright
      all_settings[:footer]&.copyright
    end

    def logo_text
      all_settings[:navigation]&.logo_text
    end

    def comments_enabled?
      all_settings[:features]&.comments || false
    end

    def site_search_enabled?
      all_settings[:features]&.site_search || false
    end

    def show_cta_button?
      all_settings[:cta_button]&.show_cta_button || false
    end

    def cta_button_text
      all_settings[:cta_button]&.cta_button_text
    end

    def email_newsletter_enabled?
      !all_settings[:email_newsletter].nil?
    end
  end
end
