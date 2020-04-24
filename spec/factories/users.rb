FactoryBot.define do
  factory :user, class: User do
    name { 'Example User' }
    sequence(:email) { |n| "user_#{n}@example.com" }
    password { "password" }
    sequence(:unique_id) { |n| "user#{n}" }
    activated { true }
    admin { 1 }
  end

  factory :other_user, class: User do
    name { 'Example Other User' }
    sequence(:email) { |n| "other_user_#{n}@example.com" }
    password { "password" }
    sequence(:unique_id) { |n| "other_user#{n}" }
    activated { true }
    admin { 0 }
  end
end