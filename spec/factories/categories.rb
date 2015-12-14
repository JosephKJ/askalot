FactoryGirl.define do
  factory :category, class: Shared::Category do
    sequence(:name) { |n| "Category ##{n}" }
    askable true

    parent_id Shared::Category.find_by(name: 'root', parent: nil).id

    trait :with_tags do
      sequence(:tags) { |n| ["category-#{n}"] }
    end

    trait :with_slido do
      slido_username 'doge'
      slido_event_prefix 'such'
    end
  end
end
