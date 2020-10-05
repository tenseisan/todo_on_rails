FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name {  Faker::Name.last_name }
    email { Faker::Internet.email }
    password { 'password' }

    trait :with_token do
      after(:create) { |user| user.create_new_auth_token }
    end
  end
end
