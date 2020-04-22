FactoryBot.define do
  factory :user do
    name { 'Example User' }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "password" }
    sequence(:unique_id) { |n| "user#{n}" }
    activated { true }
  end
end