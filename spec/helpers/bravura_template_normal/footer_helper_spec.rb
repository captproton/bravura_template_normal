# frozen_string_literal: true

# spec/helpers/bravura_template_normal/footer_helper_spec.rb
require 'rails_helper'

module BravuraTemplateNormal
  RSpec.describe FooterHelper, type: :helper do
    let(:account) { double('Account', id: 1, name: 'Test Account') }
    let(:footer_settings) { double('Settings::Footer', copyright: '© 2023 Test Account', social_media_links: nil) }
    let(:navigation_settings) { double('Settings::Navigation', logo: nil) }

    before do
      stub_const('Current', double(account:))
      allow(account).to receive(:settings_footer).and_return(footer_settings)
      allow(account).to receive(:settings_navigation).and_return(navigation_settings)
      allow(Time).to receive(:current).and_return(Time.new(2023))
    end

    describe '#social_links' do
      context 'when social media links are set' do
        let(:social_media_links) { { facebook: 'https://facebook.com/example', twitter: 'https://twitter.com/example' } }

        before do
          allow(footer_settings).to receive(:social_media_links).and_return(social_media_links)
        end

        it 'returns the social media links from footer settings' do
          expect(helper.social_links).to eq(social_media_links)
        end
      end

      context 'when social media links are not set' do
        it 'returns an empty hash' do
          expect(helper.social_links).to eq({})
        end
      end

      context 'when an error occurs' do
        before do
          allow(footer_settings).to receive(:social_media_links).and_raise(StandardError)
        end

        it 'returns an empty hash' do
          expect(helper.social_links).to eq({})
        end
      end
    end

    describe '#copyright' do
      context 'when copyright is set' do
        it 'returns the copyright from footer settings' do
          expect(helper.copyright).to eq('© 2023 Test Account')
        end
      end

      context 'when copyright is not set' do
        before do
          allow(footer_settings).to receive(:copyright).and_return(nil)
        end

        it 'returns the default copyright' do
          expect(helper.copyright).to eq('© 2023 Test Account. All rights reserved.')
        end
      end

      context 'when an error occurs' do
        before do
          allow(footer_settings).to receive(:copyright).and_raise(StandardError)
        end

        it 'returns the default copyright' do
          expect(helper.copyright).to eq('© 2023 Test Account. All rights reserved.')
        end
      end
    end

    describe '#logo_image_tag' do
      context 'when logo is attached' do
        let(:logo) { double('logo', attached?: true) }

        before do
          allow(navigation_settings).to receive(:logo).and_return(logo)
          allow(helper).to receive(:image_tag).with(logo, alt: 'Logo',
                                                          class: 'footer-logo').and_return('<img src="logo.png" alt="Logo" class="footer-logo">')
        end

        it 'returns an image tag with the logo' do
          expect(helper.logo_image_tag).to include('logo.png')
          expect(helper.logo_image_tag).to include('class="footer-logo"')
        end
      end

      context 'when logo is not attached' do
        before do
          allow(helper).to receive(:image_tag).with('default_logo.png', alt: 'Default Logo',
                                                                        class: 'footer-logo').and_return('<img src="default_logo.png" alt="Default Logo" class="footer-logo">')
        end

        it 'returns an image tag with the default logo' do
          expect(helper.logo_image_tag).to include('default_logo.png')
          expect(helper.logo_image_tag).to include('class="footer-logo"')
        end
      end

      context 'when an error occurs' do
        before do
          allow(navigation_settings).to receive(:logo).and_raise(StandardError)
          allow(helper).to receive(:image_tag).with('default_logo.png', alt: 'Default Logo',
                                                                        class: 'footer-logo').and_return('<img src="default_logo.png" alt="Default Logo" class="footer-logo">')
        end

        it 'returns an image tag with the default logo' do
          expect(helper.logo_image_tag).to include('default_logo.png')
          expect(helper.logo_image_tag).to include('class="footer-logo"')
        end
      end
    end

    describe '#render_sitemap_link' do
      context 'when sitemap is enabled' do
        before do
          allow(helper).to receive(:sitemap?).and_return(true)
        end

        it 'renders the sitemap link' do
          expect(helper.render_sitemap_link).to include('href="/_feather/sitemap.xml"')
          expect(helper.render_sitemap_link).to include('Sitemap')
        end
      end

      context 'when sitemap is disabled' do
        before do
          allow(helper).to receive(:sitemap?).and_return(false)
        end

        it 'does not render the sitemap link' do
          expect(helper.render_sitemap_link).to be_nil
        end
      end
    end
  end
end
