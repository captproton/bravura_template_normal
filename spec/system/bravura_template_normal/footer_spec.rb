# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Footer', type: :system do
  let(:account) { create(:account) }
  let!(:footer_settings) { create(:settings_footer, account:) }
  let!(:navigation_settings) { create(:settings_navigation, account:) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_account).and_return(account)
    driven_by(:rack_test)
  end

  describe 'Footer' do
    it 'displays the logo' do
      visit root_path
      expect(page).to have_css('.footer-logo')
    end

    it 'displays the company name' do
      visit root_path
      expect(page).to have_content(account.name)
    end
  end

  describe 'Footer navigation links' do
    before do
      visit root_path
    end

    it 'displays the About link' do
      expect(page).to have_link('About')
    end

    it 'displays the Contact link' do
      expect(page).to have_link('Contact')
    end
  end

  describe 'Social media links in the footer' do
    before do
      visit root_path
    end

    it 'displays the Facebook link' do
      expect(page).to have_link('', href: footer_settings.facebook_url)
    end

    it 'displays the Twitter link' do
      expect(page).to have_link('', href: footer_settings.twitter_url)
    end
  end

  it 'displays the sitemap link when enabled' do
    footer_settings.update(sitemap: true)
    visit root_path
    expect(page).to have_link('', href: '/_feather/sitemap.xml')
  end

  it 'does not display the sitemap link when disabled' do
    footer_settings.update(sitemap: false)
    visit root_path
    expect(page).to have_no_link('', href: '/_feather/sitemap.xml')
  end

  it 'displays the copyright notice' do
    visit root_path
    expect(page).to have_content(footer_settings.copyright)
  end

  describe 'Published with Bravura watermark' do
    before do
      visit root_path
    end

    it 'displays the "Published with Bravura" text' do
      expect(page).to have_content('Published with Bravura')
    end

    it 'includes a link to Feather.so with the correct UTM source' do
      expect(page).to have_link('', href: 'https://feather.so/?utm_source=watermark')
    end
  end
end
