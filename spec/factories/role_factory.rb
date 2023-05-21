FactoryBot.define do
  factory :role do
    employer
    start_year { Time.zone.now.year - 1 }
  end
end
