FactoryBot.define do
  factory :list do
    title { Faker::Book.title }
    association :user

    trait :with_jobs do
      jobs { build_list(:list_item, 2) }
    end
  end
end
