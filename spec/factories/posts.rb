# spec/factories/posts.rb
def generate_body_copy
  # title = Faker::Lorem.sentence
  paragraphs = Faker::Lorem.paragraphs(number: rand(3..10)).map { |para| "<p>#{para}</p>" }.join("\n")
  <<~HTML
    <h2 class="notion-h notion-h1 notion-h-indent-0 notion-block-4bcab883511e4f9fb7f95c6c039ded76" data-id="4bcab883511e4f9fb7f95c6c039ded76" id="disney-churros"><span><div id="4bcab883511e4f9fb7f95c6c039ded76" class="notion-header-anchor"></div><a class="notion-hash-link" href="#disney-churros" title="Disney Churros"><svg viewBox="0 0 16 16" width="16" height="16"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a><span class="notion-h-title">Disney Churros</span></span></h2>

    <div class="notion-text notion-block-e2ab09ea18204f9c8541fb84e8ed2a92">If you have ever been to Disneyland, you know that one of the most iconic snacks in the park is the churro. They are crispy, cinnamon-sugar coated, and simply delicious. In this article, we will explore the history of Disneyland churros, how they are made, and where you can find them in the park.</div>

    <h3 class="notion-h notion-h2 notion-h-indent-1 notion-block-957c44f54fd646cda883cbcfd09ed063" data-id="957c44f54fd646cda883cbcfd09ed063" id="the-history-of-disneyland-churros"><span><div id="957c44f54fd646cda883cbcfd09ed063" class="notion-header-anchor"></div><a class="notion-hash-link" href="#the-history-of-disneyland-churros" title="The History of Disneyland Churros"><svg viewBox="0 0 16 16" width="16" height="16"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a><span class="notion-h-title">The History of Disneyland Churros</span></span></h3>

    <div class="notion-text notion-block-a8eb4edc76864cceab8eaaf8140ad44b">Churros were not always a staple snack in Disneyland. In fact, they were first introduced to the park in the 1980s. At the time, Disneyland was looking for a new snack that could be sold throughout the park. They needed something that was easy to make, portable, and delicious. Churros fit the bill, and they quickly became a hit with visitors.</div>

    <div class="notion-text notion-block-3f3f723299e54d2686205033fc43f0a0">Since then, churros have become one of the most popular snacks in Disneyland. They are sold at various locations throughout the park, and you can even find specialty churros during certain events and holidays.</div>

    <h3 class="notion-h notion-h2 notion-h-indent-1 notion-block-46a7fbc4359e49569fd87ca3f614bb3e" data-id="46a7fbc4359e49569fd87ca3f614bb3e" id="how-disneyland-churros-are-made"><span><div id="46a7fbc4359e49569fd87ca3f614bb3e" class="notion-header-anchor"></div><a class="notion-hash-link" href="#how-disneyland-churros-are-made" title="How Disneyland Churros are Made"><svg viewBox="0 0 16 16" width="16" height="16"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a><span class="notion-h-title">How Disneyland Churros are Made</span></span></h3>

    <div class="notion-text notion-block-7ff7c8b8857a43a69e2b5c457c7dcc06">Disneyland churros are made using a churro machine. The dough is made from a mixture of flour, water, salt, and oil. The dough is then piped through the churro machine and fried until golden brown. Once the churros are cooked, they are rolled in a cinnamon-sugar mixture.</div>

    <div class="notion-text notion-block-511497cb23cb43f891a6458f9e39e2b9">The churros are served warm and crispy, and they are perfect for snacking on while walking around the park. They are also a great snack to share with friends and family.</div>

    <h3 class="notion-h notion-h2 notion-h-indent-1 notion-block-03e7b9904f88404c9cb05fdab71476f3" data-id="03e7b9904f88404c9cb05fdab71476f3" id="where-to-find-disneyland-churros"><span><div id="03e7b9904f88404c9cb05fdab71476f3" class="notion-header-anchor"></div><a class="notion-hash-link" href="#where-to-find-disneyland-churros" title="Where to Find Disneyland Churros"><svg viewBox="0 0 16 16" width="16" height="16"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a><span class="notion-h-title">Where to Find Disneyland Churros</span></span></h3>

    <div class="notion-text notion-block-1e136de84c504a69a3b72eeb23b6d9ed">Disneyland churros can be found at various locations throughout the park. Some of the most popular locations include:</div>

    <ul class="list-disc">
      <li>Sleeping Beauty Castle</li>
      <li>Main Street, U.S.A.</li>
      <li>New Orleans Square</li>
      <li>Pixar Pier</li>
      <li>Frontierland</li>
    </ul>

    <div class="notion-text notion-block-9b598a47517f44078d6a371d3d837762">
      #{paragraphs}
    </div>

    <h3 class="notion-h notion-h2 notion-h-indent-1 notion-block-0966d57374c3484d890aeb5041ffbb3e" data-id="0966d57374c3484d890aeb5041ffbb3e" id="conclusion"><span><div id="0966d57374c3484d890aeb5041ffbb3e" class="notion-header-anchor"></div><a class="notion-hash-link" href="#conclusion" title="Conclusion"><svg viewBox="0 0 16 16" width="16" height="16"><path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path></svg></a><span class="notion-h-title">Conclusion</span></span></h3>

    <div>
    #{paragraphs}
    </div>
  HTML
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
      post.cover.attach(io: File.open(Rails.root.join("spec", "fixtures", "files", "logo.png")), filename: "cover.jpg", content_type: "image/jpg")
      post.og_image.attach(io: File.open(Rails.root.join("spec", "fixtures", "files", "logo.png")), filename: "og_image.jpg", content_type: "image/jpg")
      post.favicon.attach(io: File.open(Rails.root.join("spec", "fixtures", "files", "favicon.png")), filename: "favicon.png", content_type: "image/png")
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
      association :author, factory: :user_two
    end

    factory :post_with_admin do
      association :author, factory: :admin
    end

    factory :post_with_twofactor do
      association :author, factory: :twofactor
    end
  end
end
