require 'spec_helper'

RSpec.describe BravuraTemplateNormal::Helper, type: :helper do
  describe '#current_footer_settings' do
    let(:account) { create(:account) }
    let!(:footer_settings) { create(:settings_footer, account:) }

    before do
      allow(helper).to receive(:Current).and_return(OpenStruct.new(account:))
    end

    it 'returns the footer settings for the current account' do
      expect(helper.current_footer_settings).to eq(footer_settings)
    end

    context 'when there is no current account' do
      before do
        allow(helper).to receive(:Current).and_return(OpenStruct.new(account: nil))
      end

      it 'returns a new Settings::Footer object' do
        expect(helper.current_footer_settings).to be_a(Settings::Footer)
        expect(helper.current_footer_settings).to be_new_record
      end
    end
  end

  # Add more helper method tests here
end
