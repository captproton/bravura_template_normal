# frozen_string_literal: true

# spec/requests/bravura_template_normal/settings_integration_spec.rb

require 'rails_helper'
require 'ostruct'
AdditionalLink = Struct.new(:name, :url)

RSpec.describe 'Settings Integration', type: :request do
  # include BravuraTemplateNormal::Engine.routes.url_helpers

  let(:mock_account) { double('Account', id: 1) }

  let(:mock_settings) do
    {
      general: double('Settings::General',
                      publication_name: 'Test Blog',
                      platform_links: { facebook: 'https://facebook.com/test' },
                      open_graph_locale: 'en_US'),
      design: double('Settings::Design',
                     site_mode: double('SiteMode', name: 'Dark'),
                     blog_theme: 'modern',
                     shades_of_gray: double('ShadesOfGray', name: '600'),
                     font_family: 'Inter'),
      footer: double('Settings::Footer',
                     copyright: '© 2024 Test Company'),
      navigation: double('Settings::Navigation',
                         logo_text: 'Test Logo',
                         logo: double('ActiveStorage::Attached', attached?: false),
                         additional_links: [
                           AdditionalLink.new('About', 'google.com'),
                           AdditionalLink.new('Contact', 'dicemediagroup.com')
                         ]),
      features: double('Settings::Feature',
                       comments: true,
                       mobile_nav: false,
                       site_search: false),
      cta_button: double('Settings::CtaButtonSetup',
                         show_cta_button: true,
                         cta_button_text: 'Click Me'),
      email_newsletter: nil
    }
  end

  before do
    allow_any_instance_of(BravuraTemplateNormal::ApplicationController).to receive(:current_account).and_return(mock_account)
    allow_any_instance_of(BravuraTemplateNormal::ApplicationController).to receive(:current_account_site_mode).and_return('dark-mode')
    allow_any_instance_of(BravuraTemplateNormal::ApplicationController).to receive(:favicon_url).and_return('/favicon.ico')

    # Mock main_app on the controller
    allow_any_instance_of(BravuraTemplateNormal::ApplicationController).to receive(:main_app).and_return(
      double('main_app', render_svg: '<svg>Mocked SVG</svg>')
    )

    allow_any_instance_of(ActionView::Base).to receive(:image_tag).and_return('<img src="mock_image.png" alt="Mock Image">')
    allow_any_instance_of(ActionView::Base).to receive(:asset_path).and_return('/mock_asset_path')

    BravuraTemplateNormal::Engine.config.bravura_template_normal.settings_provider = -> { mock_settings }
    get bravura_template_normal.root_path
  end

  it 'includes the SVG icon' do
    pending 'part of larger body of work'
    expect(response.body).to include('<svg>Mocked SVG</svg>')
  end

  # it 'returns a successful response' do
  #   pending 'part of larger body of work'
  #   expect(response).to have_http_status(:success)
  # end

  # it 'includes the Tailwind CSS stylesheet' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('stylesheet_link_tag "bravura_template_normal/application.tailwind"')
  # end

  # it 'includes the logo image' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('<img src="mock_image.png" alt="Mock Image">')
  # end

  # it 'includes the meta charset tag' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('<meta charset="utf-8">')
  # end

  # it 'includes the meta viewport tag' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('<meta name="viewport" content="width=device-width,initial-scale=1">')
  # end

  # it 'includes the meta open graph locale tag' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('<meta property="og:locale" content="en_US">')
  # end

  # it 'includes the favicon link' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('<link rel="icon" type="image/png" href="/favicon.ico">')
  # end

  # it 'includes the headings font family' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('--headings-font-family: Inter, sans-serif')
  # end

  # it 'includes the content font family' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('--content-font-family: Inter, sans-serif')
  # end

  # it 'includes the live content stylesheet' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('stylesheet_link_tag "live_content/normal"')
  # end

  # it 'includes the blog app stylesheet' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('stylesheet_link_tag "blog_app/app-DTZPEUWL"')
  # end

  # it 'uses the correct publication name' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('Test Blog')
  # end

  # it 'applies the correct theme' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('data-theme="modern"')
  # end

  # it 'applies the correct gray theme' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('data-graytheme="gray600"')
  # end

  # it 'applies the correct site mode' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('data-mode="Dark"')
  # end

  # it 'includes the correct classes for dark mode' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to
  #   include('class="overflow-x-hidden bg-white font-sans text-secondary-900 antialiased dark-mode"')
  # end

  # it 'displays the logo text' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('Test Logo')
  # end

  # it 'displays the copyright information' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('© 2024 Test Company')
  # end

  # it 'displays the CTA button' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('Click Me')
  # end

  # it 'includes the comments section' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('comments-section')
  # end

  # it 'does not include the search bar' do
  #   expect(response.body).not_to include('search-bar')
  # end

  # it 'displays the Facebook social link' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('https://facebook.com/test')
  # end

  # it 'does not display the search button when disabled' do
  #   expect(response.body).not_to include('site-search-btn')
  # end

  # it 'does not include mobile navigation when disabled' do
  #   expect(response.body).not_to include('right_nav_links_mobile')
  # end

  # it 'includes the Blog Home link' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('Blog Home')
  # end

  # it 'includes the Blog Home link class' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('nav-link-3fcd12e9-1b30-4b8d-9f02-76ed1ba17043')
  # end

  # # navigation links
  # it 'includes the About navigation link' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('About')
  # end

  # it 'includes the About navigation link URL' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('google.com')
  # end

  # it 'includes the Contact navigation link' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('Contact')
  # end

  # it 'includes the Contact navigation link URL' do
  #   pending 'part of larger body of work'
  #   expect(response.body).to include('dicemediagroup.com')
  # end
end
