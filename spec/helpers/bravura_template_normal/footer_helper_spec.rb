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
      allow(account).to receive_messages(settings_footer: footer_settings, settings_navigation: navigation_settings)
      allow(Time).to receive(:current).and_return(Time.zone.local(2023))
      helper.extend(described_class)
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

    describe '#render_sitemap_link' do
      context 'when sitemap is enabled' do
        before do
          helper.instance_variable_set(:@sitemap, true)
        end

        it 'includes the correct href in the sitemap link' do
          expect(helper.render_sitemap_link).to include('href="/_feather/sitemap.xml"')
        end

        it 'includes the link text "Sitemap"' do
          expect(helper.render_sitemap_link).to include('Sitemap')
        end
      end

      context 'when sitemap is disabled' do
        before do
          helper.instance_variable_set(:@sitemap, false)
        end

        it 'does not render the sitemap link' do
          expect(helper.render_sitemap_link).to be_nil
        end
      end
    end
  end
end
