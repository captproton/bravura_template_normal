# frozen_string_literal: true

class DummyController < ApplicationController
  def index
    render inline: <<-ERB
      <!DOCTYPE html>
      <html>
        <body>
          <%= render 'layouts/bravura_template_normal/footer' %>
        </body>
      </html>
    ERB
  end
end
