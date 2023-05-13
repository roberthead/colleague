FactoryBot.define do
  factory :employer do
    resume
    sequence(:name) { |n| "Employer #{n}" }
  end
end
