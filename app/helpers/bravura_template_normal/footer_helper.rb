# frozen_string_literal: true

# app/helpers/bravura_template_normal/footer_helper.rb
# Provides view helper methods that span across all public-facing pages for the BravuraTemplateNormal engine

module BravuraTemplateNormal
  module FooterHelper
    def social_links
      current_footer_settings&.social_media_links || {}
    rescue StandardError
      {}
    end

    def current_footer_settings
      @current_footer_settings ||= Current.account.settings_footer
    end

    def copyright
      current_footer_settings&.copyright || default_copyright
    rescue StandardError
      default_copyright
    end

    def logo_image_tag
      navigation_settings = Current.account.settings_navigation
      if navigation_settings&.logo&.attached?
        image_tag(navigation_settings.logo, alt: 'Logo', class: 'footer-logo')
      else
        image_tag('default_logo.png', alt: 'Default Logo', class: 'footer-logo')
      end
    rescue StandardError
      image_tag('default_logo.png', alt: 'Default Logo', class: 'footer-logo')
    end

    def render_sitemap_link
      link_to('Sitemap', '/_feather/sitemap.xml') if sitemap?
    end

    def sitemap?
      # Your logic to determine if sitemap should be shown
      # For example:
      !!@sitemap
    end

    private

    def default_copyright
      "© #{Time.current.year} #{Current.account.name}. All rights reserved."
    end
  end
end
