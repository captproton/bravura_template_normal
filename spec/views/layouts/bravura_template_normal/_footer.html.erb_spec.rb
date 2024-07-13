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
    allow(view).to receive(:current_footer_settings).and_return(footer_settings)
    allow(view).to receive(:social_links).and_return({
                                                       facebook: 'https://facebook.com',
                                                       twitter: 'https://twitter.com'
                                                     })
    allow(view).to receive(:render_svg).and_return('<svg></svg>')
  end

  it 'renders the logo and company name' do
    render
    expect(rendered).to have_css('.footer-logo')
    expect(rendered).to have_content('Company Name')
  end

  it 'renders the footer navigation links' do
    render
    expect(rendered).to have_link('About', href: 'https://example.com/about')
    expect(rendered).to have_link('Contact', href: 'https://example.com/contact')
  end

  it 'renders the social media links' do
    render
    expect(rendered).to have_css("a[href='https://facebook.com']")
    expect(rendered).to have_css("a[href='https://twitter.com']")
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

  it 'renders the "Published with Bravura" watermark' do
    render
    expect(rendered).to have_content('Published with Bravura')
    expect(rendered).to have_css("a[href='https://feather.so/?utm_source=watermark']")
  end
end
