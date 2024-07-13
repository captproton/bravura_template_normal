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

  it 'displays the logo and company name' do
    visit root_path
    expect(page).to have_css('.footer-logo')
    expect(page).to have_content(account.name)
  end

  it 'displays the footer navigation links' do
    visit root_path
    expect(page).to have_link('About')
    expect(page).to have_link('Contact')
  end

  it 'displays the social media links' do
    visit root_path
    expect(page).to have_link('', href: footer_settings.facebook_url)
    expect(page).to have_link('', href: footer_settings.twitter_url)
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

  it 'displays the "Published with Bravura" watermark' do
    visit root_path
    expect(page).to have_content('Published with Bravura')
    expect(page).to have_link('', href: 'https://feather.so/?utm_source=watermark')
  end
end
