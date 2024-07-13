# frozen_string_literal: true

# spec/helpers/bravura_template_normal/footer_helper_spec.rb
require 'rails_helper'

RSpec.describe BravuraTemplateNormal::FooterHelper, type: :helper do
  let(:account) { create(:account) }
  let(:footer_settings) { create(:settings_footer, account:) }
  let(:navigation_settings) { create(:settings_navigation, account:) }

  before do
    allow(helper).to receive_messages(current_account: account, current_footer_settings: footer_settings)
  end

  describe '#social_links' do
    it 'returns a hash of social media links' do
      expect(helper.social_links).to be_a(Hash)
      expect(helper.social_links.keys).to include(:facebook, :twitter, :instagram)
    end
  end

  describe '#current_footer_settings' do
    it 'returns the footer settings for the current account' do
      expect(helper.current_footer_settings).to eq(footer_settings)
    end
  end

  describe '#logo_image_tag' do
    context 'when logo is attached' do
      before do
        navigation_settings.logo.attach(io: Rails.root.join('spec/fixtures/files/logo.png').open,
                                        filename: 'logo.png')
      end

      it 'returns an image tag with the logo' do
        expect(helper.logo_image_tag).to include('logo.png')
      end
    end

    context 'when logo is not attached' do
      it 'returns an image tag with the default logo' do
        expect(helper.logo_image_tag).to include('default_logo.png')
      end
    end
  end
end
