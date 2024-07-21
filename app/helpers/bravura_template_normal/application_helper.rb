# frozen_string_literal: true

# app/helpers/bravura_template_normal/application_helper.rb
module BravuraTemplateNormal
  # ApplicationHelper contains helper methods for use across the BravuraTemplateNormal engine.
  # These methods assist in rendering common elements such as favicons and social links.
  module ApplicationHelper
    include SettingsHelper
    include ::ApplicationHelper # This includes the main app's ApplicationHelper

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

    def social_links
      all_settings[:general]&.platform_links || {}
    end

    # Uncomment and adjust if you need a custom render_svg method
    # def render_svg(filename, options = {})
    #   if defined?(inline_svg_tag)
    #     options[:title] ||= filename.underscore.humanize
    #     options[:aria] = true
    #     options[:nocomment] = true
    #     options[:class] = options.fetch(:styles, 'fill-current text-gray-500')
    #     inline_svg_tag(filename, options)
    #   else
    #     # Fallback for when inline_svg_tag is not available (e.g., in tests)
    #     '<svg>SVG not available in this environment</svg>'
    #   end
    # end
  end
end
