FactoryBot.define do
  factory :account do
    name { Faker::Company.name }
    domain { Faker::Internet.domain_name }
  end

  factory :settings_footer, class: 'Settings::Footer' do
    association :account
    footer_description { Faker::Lorem.paragraph }
    sitemap { Faker::Boolean.boolean }
    rss_feed { Faker::Boolean.boolean }
    copyright { "Copyright © #{Time.current.year} #{Faker::Company.name}" }
  end
end
