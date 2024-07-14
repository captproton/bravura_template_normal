# frozen_string_literal: true

class DummyController < ApplicationController
  def index
    # rubocop:disable Rails/RenderInline
    render inline: <<-ERB
      <!DOCTYPE html>
      <html>
        <body>
          <%= render 'layouts/bravura_template_normal/footer' %>
        </body>
      </html>
    ERB
    # rubocop:enable Rails/RenderInline
  end
end
