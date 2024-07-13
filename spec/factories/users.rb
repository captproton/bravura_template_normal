# spec/factories/users.rb

# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { "password" }
    terms_of_service { true }
    time_zone { "Eastern Time (US & Canada)" }
    confirmed_at { Time.current }
    skip_default_account { true }
    accepted_terms_at { Time.current }
    accepted_privacy_at { Time.current }

    trait :admin do
      admin { true }
    end

    trait :with_company_account do
      after(:create) do |user|
        create(:account_user, :company_admin, user: user)
      end
    end

    trait :author do
      after(:create) do |user|
        create(:draft_post, author: user)
      end
    end

    trait :with_two_factor do
      otp_required_for_login { true }
      otp_secret { "NJZNMRJFS6XBRMZ4NDEDAUIYIVTBJXOM" }
      otp_backup_codes { ["0000000001", "0000000002", "0000000003", "0000000004", "0000000005"] }
    end

    factory :user_one do
      email { "one@example.com" }
      first_name { "User" }
      last_name { "One" }
      time_zone { "Central Time (US & Canada)" }
    end

    factory :user_two do
      email { "two@example.com" }
      first_name { "User" }
      last_name { "Two" }
      time_zone { "Central Time (US & Canada)" }
    end

    factory :user_admin do
      email { "admin@example.com" }
      first_name { "Admin" }
      last_name { "User" }
      time_zone { "Central Time (US & Canada)" }
      admin { true }
    end

    factory :user_invited do
      email { "invited@example.com" }
      first_name { "Invited" }
      last_name { "User" }
      time_zone { "Central Time (US & Canada)" }
    end

    factory :user_noaccount do
      email { "noaccount@example.com" }
      first_name { "No Account" }
      last_name { "User" }
      time_zone { "Central Time (US & Canada)" }
    end

    factory :user_without_billing_address do
      email { "noaddress@example.com" }
      first_name { "User" }
      last_name { "NoAddress" }
      time_zone { "Central Time (US & Canada)" }
    end

    factory :user_fake_processor do
      email { "fake@example.com" }
      first_name { "Fake" }
      last_name { "Processor" }
      time_zone { "Central Time (US & Canada)" }
    end
  end
end
