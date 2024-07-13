# frozen_string_literal: true

# spec/factories/bravura_template_normal/accounts.rb
FactoryBot.define do
  factory :bravura_template_normal_account, class: 'BravuraTemplateNormal::Account' do
    sequence(:name) { |n| "Account #{n}" }
    # Add other necessary attributes
  end
end
