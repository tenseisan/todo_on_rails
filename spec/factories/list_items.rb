FactoryBot.define do
  factory :list_item do
    title { Faker::Book.title }
    association :list
  end
end
