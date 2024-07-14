# frozen_string_literal: true

# spec/support/system_spec_helper.rb

module SystemSpecHelper
  def root_path
    '/'
  end

  def render_svg(*)
    '<svg></svg>'
  end
end
