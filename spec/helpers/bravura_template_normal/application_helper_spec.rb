# frozen_string_literal: true

# spec/helpers/bravura_template_normal/application_helper_spec.rb
require 'rails_helper'

module BravuraTemplateNormal
  RSpec.describe ApplicationHelper, type: :helper do
    include BravuraTemplateNormal::ApplicationHelper

    let(:main_app) { double('main_app') }
    let(:mock_settings) do
      {
        general: double('Settings::General', favicon: nil, platform_links: nil)
      }
    end

    before do
      allow(helper).to receive(:main_app).and_return(main_app)
      allow(helper).to receive(:all_settings).and_return(mock_settings)
    end

    describe '#favicon_url' do
      it 'delegates to main_app' do
        expect(main_app).to receive(:favicon_url).and_return('http://example.com/favicon.ico')
        expect(helper.favicon_url).to eq('http://example.com/favicon.ico')
      end
    end

    describe '#social_links' do
      context 'when platform links are set' do
        let(:platform_links) { { facebook: 'https://facebook.com/example', twitter: 'https://twitter.com/example' } }

        before do
          allow(mock_settings[:general]).to receive(:platform_links).and_return(platform_links)
        end

        it 'returns the platform links from general settings' do
          expect(helper.social_links).to eq(platform_links)
        end
      end

      context 'when platform links are not set' do
        it 'returns an empty hash' do
          expect(helper.social_links).to eq({})
        end
      end
    end

    describe 'method delegation' do
      it 'delegates unknown methods to main_app' do
        expect(main_app).to receive(:unknown_method).with('arg').and_return('result')
        expect(helper.unknown_method('arg')).to eq('result')
      end

      it 'raises NoMethodError for methods not in main_app' do
        allow(main_app).to receive(:respond_to?).with(:non_existent_method).and_return(false)
        expect { helper.non_existent_method }.to raise_error(NoMethodError)
      end
    end
  end
end
