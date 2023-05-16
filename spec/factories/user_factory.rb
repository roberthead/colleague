FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    name { email.split("@").first.split(/\W+/).map(&:titleize).join(" ") }
    password { "password" }
    admin { false }
  end
end
