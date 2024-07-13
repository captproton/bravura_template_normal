# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'layouts/bravura_template_normal/_footer', type: :view do
  let(:account) { create(:account) }
  let(:footer_settings) { create(:settings_footer, account:) }
  let(:navigation_settings) { create(:settings_navigation, account:) }

  before do
    assign(:current_account, account)
    assign(:logo_text, 'Company Name')
    assign(:footer_nav_links, [
             OpenStruct.new(name: 'About', url: 'https://example.com/about'),
             OpenStruct.new(name: 'Contact', url: 'https://example.com/contact')
           ])
    allow(view).to receive_messages(current_footer_settings: footer_settings, social_links: {
                                      facebook: 'https://facebook.com',
                                      twitter: 'https://twitter.com'
                                    }, render_svg: '<svg></svg>')
  end

  describe 'Footer content' do
    before do
      render
    end

    it 'renders the logo' do
      expect(rendered).to have_css('.footer-logo')
    end

    it 'renders the company name' do
      expect(rendered).to have_content('Company Name')
    end
  end

  describe 'Footer navigation links' do
    before do
      render
    end

    it 'renders the About link' do
      expect(rendered).to have_link('About', href: 'https://example.com/about')
    end

    it 'renders the Contact link' do
      expect(rendered).to have_link('Contact', href: 'https://example.com/contact')
    end
  end

  describe 'Social media links' do
    before do
      render
    end

    it 'renders the Facebook link' do
      expect(rendered).to have_css("a[href='https://facebook.com']")
    end

    it 'renders the Twitter link' do
      expect(rendered).to have_css("a[href='https://twitter.com']")
    end
  end

  it 'renders the sitemap link when @sitemap is true' do
    assign(:sitemap, true)
    render
    expect(rendered).to have_link(href: '/_feather/sitemap.xml')
  end

  it 'does not render the sitemap link when @sitemap is false' do
    assign(:sitemap, false)
    render
    expect(rendered).to have_no_link(href: '/_feather/sitemap.xml')
  end

  it 'renders the copyright notice' do
    render
    expect(rendered).to have_content(footer_settings.copyright)
  end

  describe 'Published with Bravura watermark' do
    before do
      render
    end

    it 'renders the "Published with Bravura" text' do
      expect(rendered).to have_content('Published with Bravura')
    end

    it 'includes a link to Feather.so with the correct UTM source' do
      expect(rendered).to have_css("a[href='https://feather.so/?utm_source=watermark']")
    end
  end
end
