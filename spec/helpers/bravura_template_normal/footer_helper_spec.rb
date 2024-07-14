# spec/helpers/bravura_template_normal/footer_helper_spec.rb
require 'rails_helper'

module BravuraTemplateNormal
  RSpec.describe FooterHelper, type: :helper do
    let(:account) { double('Account', id: 1, name: 'Test Account') }
    let(:footer_settings) { double('Settings::Footer', social_media_links: nil, copyright: nil) }
    let(:navigation_settings) { double('Settings::Navigation', logo: nil) }

    before do
      stub_const('Current', double(account:))
      allow(account).to receive(:settings_footer).and_return(footer_settings)
      allow(account).to receive(:settings_navigation).and_return(navigation_settings)
    end

    describe '#social_links' do
      context 'when footer settings exist' do
        let(:social_media_links) { { facebook: 'https://facebook.com/example', twitter: 'https://twitter.com/example' } }

        before do
          allow(footer_settings).to receive(:social_media_links).and_return(social_media_links)
        end

        it 'returns the social media links from footer settings' do
          expect(helper.social_links).to eq(social_media_links)
        end
      end

      context 'when footer settings do not exist' do
        before do
          allow(account).to receive(:settings_footer).and_return(nil)
        end

        it 'returns an empty hash' do
          expect(helper.social_links).to eq({})
        end
      end

      context 'when social_media_links is nil' do
        before do
          allow(footer_settings).to receive(:social_media_links).and_return(nil)
        end

        it 'returns an empty hash' do
          expect(helper.social_links).to eq({})
        end
      end
    end

    describe '#current_footer_settings' do
      it 'returns the footer settings for the current account' do
        expect(helper.current_footer_settings).to eq(footer_settings)
      end
    end

    describe '#copyright' do
      context 'when footer settings exist and have a copyright' do
        let(:custom_copyright) { 'Custom Copyright 2023' }

        before do
          allow(footer_settings).to receive(:copyright).and_return(custom_copyright)
        end

        it 'returns the custom copyright' do
          expect(helper.copyright).to eq(custom_copyright)
        end
      end

      context 'when footer settings do not exist' do
        before do
          allow(account).to receive(:settings_footer).and_return(nil)
          allow(Time).to receive(:current).and_return(Time.new(2023))
        end

        it 'returns a default copyright message' do
          expect(helper.copyright).to eq('© 2023 Test Account. All rights reserved.')
        end
      end

      context 'when copyright is nil' do
        before do
          allow(Time).to receive(:current).and_return(Time.new(2023))
        end

        it 'returns a default copyright message' do
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
    end
  end
end
