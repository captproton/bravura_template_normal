# spec/helpers/bravura_template_normal/settings_helper_spec.rb

require 'rails_helper'

module BravuraTemplateNormal
  RSpec.describe SettingsHelper, type: :helper do
    let(:mock_settings) do
      {
        general: double('Settings::General', publication_name: 'Test Blog'),
        design: double('Settings::Design', site_mode: double('SiteMode', name: 'Dark')),
        footer: double('Settings::Footer', copyright: '© 2024 Test Company'),
        navigation: double('Settings::Navigation', logo_text: 'Test Logo'),
        features: double('Settings::Feature', comments: true, site_search: false),
        cta_button: double('Settings::CtaButtonSetup', show_cta_button: true, cta_button_text: 'Click Me'),
        email_newsletter: nil
      }
    end

    before do
      allow(helper).to receive(:all_settings).and_return(mock_settings)
    end

    describe '#publication_name' do
      it 'returns the publication name from general settings' do
        expect(helper.publication_name).to eq('Test Blog')
      end
    end

    describe '#dark_mode?' do
      it 'returns true when site mode is Dark' do
        expect(helper.dark_mode?).to be true
      end
    end

    describe '#footer_copyright' do
      it 'returns the copyright text from footer settings' do
        expect(helper.footer_copyright).to eq('© 2024 Test Company')
      end
    end

    describe '#logo_text' do
      it 'returns the logo text from navigation settings' do
        expect(helper.logo_text).to eq('Test Logo')
      end
    end

    describe '#comments_enabled?' do
      it 'returns true when comments feature is enabled' do
        expect(helper.comments_enabled?).to be true
      end
    end

    describe '#site_search_enabled?' do
      it 'returns false when site search feature is disabled' do
        expect(helper.site_search_enabled?).to be false
      end
    end

    describe '#show_cta_button?' do
      it 'returns true when CTA button is set to show' do
        expect(helper.show_cta_button?).to be true
      end
    end

    describe '#cta_button_text' do
      it 'returns the CTA button text' do
        expect(helper.cta_button_text).to eq('Click Me')
      end
    end

    describe '#email_newsletter_enabled?' do
      it 'returns false when email newsletter settings are nil' do
        expect(helper.email_newsletter_enabled?).to be false
      end
    end
  end
end
