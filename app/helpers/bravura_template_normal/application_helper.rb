# frozen_string_literal: true

module BravuraTemplateNormal
  # ApplicationHelper provides helper methods for views in BravuraTemplateNormal
  module ApplicationHelper
    include SettingsHelper
    include ::ApplicationHelper

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

    def render_svg(name, options = {})
      options[:title] ||= name.underscore.humanize
      options[:aria] = true
      options[:nocomment] = true
      options[:class] = options.fetch(:styles, 'fill-current text-gray-500')
      filename = "#{name}.svg"

      if respond_to?(:inline_svg_tag)
        inline_svg_tag(filename, options)
      else
        render_svg_fallback(filename, options)
      end
    end

    private

    def render_svg_fallback(filename, options)
      file_path = Rails.root.join('app', 'assets', 'images', filename)
      if File.exist?(file_path)
        file_contents = File.read(file_path)
        sanitized_contents = sanitize_svg(file_contents)
        encoded_svg = Base64.strict_encode64(sanitized_contents)
        image_tag("data:image/svg+xml;base64,#{encoded_svg}", options)
      else
        content_tag(:span, "SVG not found: #{filename}", class: 'svg-not-found')
      end
    end

    def sanitize_svg(svg_contents)
      require 'loofah'
      Loofah.xml_fragment(svg_contents).scrub!(:prune).to_s
    end
  end
end
