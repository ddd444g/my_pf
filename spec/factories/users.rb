FactoryBot.define do
  factory :user do
    name { "test" }
    # password { "test_password" }
    password { "test_password" }
    password_confirmation { "test_password" }
    sequence(:email) { |n| "user_#{n}@example.com" }
  end
end
