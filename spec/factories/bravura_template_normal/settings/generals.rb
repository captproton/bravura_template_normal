# frozen_string_literal: true

# spec/factories/bravura_template_normal/settings/generals.rb
FactoryBot.define do
  factory :bravura_template_normal_settings_general, class: 'BravuraTemplateNormal::Settings::General' do
    account factory: %i[bravura_template_normal_account]
    # Add other necessary attributes
  end
end
