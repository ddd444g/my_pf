FactoryBot.define do
  factory :user do
    name { "test" }
    sequence(:email) { |n| "user_#{n}@example.com" }
  end
end
