# frozen_string_literal: true

# spec/lib/bravura_template_normal/engine_spec.rb

require 'rails_helper'

RSpec.describe BravuraTemplateNormal::Engine do
  describe 'settings provider configuration' do
    let(:mock_settings) do
      {
        general: double('Settings::General'),
        design: double('Settings::Design'),
        footer: double('Settings::Footer'),
        navigation: double('Settings::Navigation'),
        features: double('Settings::Feature'),
        cta_button: double('Settings::CtaButtonSetup'),
        email_newsletter: nil
      }
    end

    it 'sets up a default settings provider' do
      expect(described_class.config.bravura_template_normal.settings_provider).to be_a(Proc)
    end

    context 'when overriding the settings provider' do
      let(:custom_provider) { -> { mock_settings } }
      let(:original_provider) { described_class.config.bravura_template_normal.settings_provider }

      before do
        described_class.config.bravura_template_normal.settings_provider = custom_provider
      end

      after do
        described_class.config.bravura_template_normal.settings_provider = original_provider
      end

      it 'allows the settings provider to be changed' do
        expect(described_class.config.bravura_template_normal.settings_provider).to eq(custom_provider)
      end

      it 'returns the mock settings when called' do
        expect(described_class.config.bravura_template_normal.settings_provider.call).to eq(mock_settings)
      end

      it 'returns a general settings object' do
        settings = described_class.config.bravura_template_normal.settings_provider.call
        expect(settings[:general]).to be_a(RSpec::Mocks::Double)
      end

      it 'returns a design settings object' do
        settings = described_class.config.bravura_template_normal.settings_provider.call
        expect(settings[:design]).to be_a(RSpec::Mocks::Double)
      end

      it 'returns a footer settings object' do
        settings = described_class.config.bravura_template_normal.settings_provider.call
        expect(settings[:footer]).to be_a(RSpec::Mocks::Double)
      end

      it 'returns a navigation settings object' do
        settings = described_class.config.bravura_template_normal.settings_provider.call
        expect(settings[:navigation]).to be_a(RSpec::Mocks::Double)
      end

      it 'returns a features settings object' do
        settings = described_class.config.bravura_template_normal.settings_provider.call
        expect(settings[:features]).to be_a(RSpec::Mocks::Double)
      end

      it 'returns a CTA button settings object' do
        settings = described_class.config.bravura_template_normal.settings_provider.call
        expect(settings[:cta_button]).to be_a(RSpec::Mocks::Double)
      end

      it 'returns nil for email newsletter settings' do
        settings = described_class.config.bravura_template_normal.settings_provider.call
        expect(settings[:email_newsletter]).to be_nil
      end
    end
  end
end
