# frozen_string_literal: true

# spec/helpers/bravura_template_normal/application_helper_spec.rb

require 'rails_helper'

module BravuraTemplateNormal
  RSpec.describe ApplicationHelper, type: :helper do
    let(:mock_settings) do
      {
        general: double('Settings::General', favicon: nil, platform_links: nil)
      }
    end

    before do
      allow(helper).to receive(:all_settings).and_return(mock_settings)
    end

    describe '#favicon_url' do
      context 'when favicon is attached' do
        let(:favicon) { double('ActiveStorage::Attached', attached?: true) }

        before do
          allow(mock_settings[:general]).to receive(:favicon).and_return(favicon)
          allow(helper).to receive(:rails_blob_url).with(favicon).and_return('http://example.com/favicon.ico')
        end

        it 'returns the favicon url' do
          expect(helper.favicon_url).to eq('http://example.com/favicon.ico')
        end
      end

      context 'when favicon is not attached' do
        before do
          allow(helper).to receive(:asset_path).with('default_favicon.png').and_return('/assets/default_favicon.png')
        end

        it 'returns the default favicon path' do
          expect(helper.favicon_url).to eq('/assets/default_favicon.png')
        end
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
  end
end
