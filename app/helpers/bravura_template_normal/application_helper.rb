# frozen_string_literal: true

# app/helpers/bravura_template_normal/application_helper.rb

module BravuraTemplateNormal
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

      # Check if inline_svg_tag is available
      if respond_to?(:inline_svg_tag)
        inline_svg_tag(filename, options)
      else
        # Fallback method if inline_svg_tag is not available
        render_svg_fallback(filename, options)
      end
    end

    private

    def render_svg_fallback(filename, options)
      file_path = Rails.root.join('app', 'assets', 'images', filename)
      if File.exist?(file_path)
        file_contents = File.read(file_path)
        content_tag(:span, file_contents.html_safe, class: options[:class], title: options[:title])
      else
        content_tag(:span, "SVG not found: #{filename}", class: 'svg-not-found')
      end
    end
  end
end
