# frozen_string_literal: true

# spec/system/bravura_template_normal/footer_spec.rb

require 'rails_helper'
require 'ostruct'

RSpec.describe 'Footer', type: :system do
  let(:account) { double('Account', id: 1, name: 'Test Account') }
  let(:footer_settings) do
    double('Settings::Footer',
           social_media_links: { facebook: 'https://facebook.com/test', twitter: 'https://twitter.com/test' },
           copyright: '© 2023 Test Account',
           sitemap: false)
  end
  let(:navigation_settings) { double('Settings::Navigation', logo: nil) }

  before do
    stub_const('Current', double(account:))
    allow(account).to receive(:settings_footer).and_return(footer_settings)
    allow(account).to receive(:settings_navigation).and_return(navigation_settings)

    # Define render_svg method in the test environment
    ActionView::Base.class_eval do
      def render_svg(name)
        "<svg>#{name}</svg>"
      end
    end

    # Include necessary helpers
    RSpec.configure do |config|
      config.include BravuraTemplateNormal::FooterHelper
      config.include ActionView::Helpers::AssetTagHelper
      config.include ActionView::Helpers::UrlHelper
    end

    # Set instance variables that the partial expects
    assign(:current_account, account)
    assign(:logo_text, 'Test Account')
    assign(:footer_nav_links, [
             OpenStruct.new(name: 'About', url: 'https://google.com'),
             OpenStruct.new(name: 'Contact', url: 'https://dicemediagroup.com')
           ])
    assign(:sitemap, false)

    # Stub helper methods
    allow_any_instance_of(ActionView::Base).to receive(:current_footer_settings).and_return(footer_settings)
    allow_any_instance_of(ActionView::Base).to receive(:logo_image_tag).and_return('<img src="default_logo.png" alt="Default Logo" class="h-8 w-auto mr-1">')
    allow_any_instance_of(ActionView::Base).to receive(:root_path).and_return('/')

    # Set up routes
    Rails.application.routes.draw do
      root 'dummy#index'
    end

    # Define DummyController inline
    class DummyController < ActionController::Base
      def index
        render template: 'layouts/application'
      end
    end

    # Stub the application layout
    allow_any_instance_of(ActionView::Base).to receive(:render).and_wrap_original do |original_method, *args|
      if args.first == { template: 'layouts/application' }
        <<-ERB
          <!DOCTYPE html>
          <html>
            <body>
              <%= render 'layouts/bravura_template_normal/footer' %>
            </body>
          </html>
        ERB
      else
        original_method.call(*args)
      end
    end

    driven_by(:rack_test)
    visit '/'
  end

  describe 'Footer content' do
    it 'displays the logo text' do
      expect(page).to have_content('Test Account')
    end

    it 'displays the default logo' do
      expect(page).to have_css('img[src*="default_logo.png"]')
    end
  end

  describe 'Footer navigation links' do
    it 'displays the About link' do
      expect(page).to have_link('About', href: 'https://google.com')
    end

    it 'displays the Contact link' do
      expect(page).to have_link('Contact', href: 'https://dicemediagroup.com')
    end
  end

  describe 'Social media links' do
    it 'displays the Facebook link' do
      expect(page).to have_link('', href: 'https://facebook.com/test')
    end

    it 'displays the Twitter link' do
      expect(page).to have_link('', href: 'https://twitter.com/test')
    end
  end

  it 'displays the copyright notice' do
    expect(page).to have_content('© 2023 Test Account')
  end

  describe 'Published with Bravura watermark' do
    it 'displays the "Published with Bravura" text' do
      expect(page).to have_content('Published with Bravura')
    end

    it 'includes a link to Feather.so with the correct UTM source' do
      expect(page).to have_link('', href: 'https://feather.so/?utm_source=watermark')
    end
  end
end
