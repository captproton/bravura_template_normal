# frozen_string_literal: true

# app/helpers/bravura_template_normal/application_helper.rb

module BravuraTemplateNormal
  # ApplicationHelper contains helper methods for use across the BravuraTemplateNormal engine.
  # These methods assist in rendering common elements such as favicons and social links.
  module ApplicationHelper
    include SettingsHelper

    def favicon_url
      if all_settings[:general]&.favicon&.attached?
        rails_blob_url(all_settings[:general].favicon)
      else
        asset_path('default_favicon.png')
      end
    end

    def social_links
      all_settings[:general]&.platform_links || {}
    end

    def render_svg(filename, options = {})
      if defined?(inline_svg_tag)
        options[:title] ||= name.underscore.humanize
        options[:aria] = true
        options[:nocomment] = true
        options[:class] = options.fetch(:styles, 'fill-current text-gray-500')

        filename = "#{name}.svg"
        inline_svg_tag(filename, options)
      else
        # Fallback for when inline_svg_tag is not available (e.g., in tests)
        '<svg>SVG not available in this environment</svg>'
      end
    end
  end
end
