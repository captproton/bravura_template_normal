# frozen_string_literal: true

# spec/factories/posts.rb
def generate_body_copy
  [generate_intro, generate_main_content, generate_conclusion].join("\n\n")
end

def generate_intro
  'Introduction content...'
end

def generate_main_content
  # Simulating the generation of main content with placeholder text.
  'Main content goes here. This could be multiple paragraphs or sections.'
end

def generate_conclusion
  # Simulating the generation of a conclusion with placeholder text.
  'Conclusion content. Summarizing the post.'
end

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    body_copy { generate_body_copy }

    published_at { Faker::Date.backward(days: 14) }
    hide_cover { false }
    featured { false }
    hidden_from_main_feed { false }
    do_not_index { false }
    meta_title { Faker::Lorem.sentence }
    meta_description { Faker::Lorem.paragraph }
    hide_cta { Faker::Boolean.boolean }
    canonical_url { Faker::Internet.url }
    account { create(:account, :company) }

    after(:build) do |post|
      account_user = create(:account_user, account: post.account, user: create(:user))
      post.author = account_user.user
      post.cover.attach(io: Rails.root.join('spec/fixtures/files/logo.png').open, filename: 'cover.jpg',
                        content_type: 'image/jpg')
      post.og_image.attach(io: Rails.root.join('spec/fixtures/files/logo.png').open,
                           filename: 'og_image.jpg', content_type: 'image/jpg')
      post.favicon.attach(io: Rails.root.join('spec/fixtures/files/favicon.png').open,
                          filename: 'favicon.png', content_type: 'image/png')
    end

    trait :hidden do
      hidden_from_main_feed { true }
    end

    trait :featured do
      featured { true }
    end

    factory :draft_post do
      published_at { nil }
    end

    factory :post_with_user_two do
      author factory: %i[user_two]
    end

    factory :post_with_admin do
      author factory: %i[admin]
    end

    factory :post_with_twofactor do
      author factory: %i[twofactor]
    end
  end
end
