# frozen_string_literal: true

require 'rails_helper'
require 'ostruct'

# Define a helper module for the specs
module SpecHelper
  def render_svg(*)
    '<svg></svg>'
  end

  def root_path
    '/'
  end
end
