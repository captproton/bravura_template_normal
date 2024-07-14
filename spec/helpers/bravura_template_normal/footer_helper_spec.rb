require 'rails_helper'

module BravuraTemplateNormal
  RSpec.describe FooterHelper, type: :helper do
    let(:account) { double('Account', id: 1) }
    let(:footer_settings) { double('Settings::Footer', social_media_links: {}) }
    let(:navigation_settings) { double('Settings::Navigation', logo: nil) }

    before do
      stub_const('Current', double(account:))
      allow(account).to receive(:settings_footer).and_return(footer_settings)
      allow(account).to receive(:settings_navigation).and_return(navigation_settings)
    end

    describe '#social_links' do
      let(:social_media_links) { { facebook: 'https://facebook.com/example', twitter: 'https://twitter.com/example' } }

      before do
        allow(footer_settings).to receive(:social_media_links).and_return(social_media_links)
      end

      it 'returns the social media links from footer settings' do
        expect(helper.social_links).to eq(social_media_links)
      end
    end

    describe '#current_footer_settings' do
      it 'returns the footer settings for the current account' do
        expect(helper.current_footer_settings).to eq(footer_settings)
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
    end
  end
end
