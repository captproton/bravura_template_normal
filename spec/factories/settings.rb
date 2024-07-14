# frozen_string_literal: true

FactoryBot.define do
  factory :settings_footer, class: 'Settings::Footer' do
    account
    footer_description { Faker::Lorem.paragraph }
    sitemap { Faker::Boolean.boolean }
    rss_feed { Faker::Boolean.boolean }
    copyright { "Copyright © #{Time.current.year} #{Faker::Company.name}" }
  end
end
