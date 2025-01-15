FactoryBot.define do
  factory :challenge do
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    start_date { Date.today }
    team { nil }
  end
end
