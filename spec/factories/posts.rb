FactoryBot.define do
  factory :post do
    map_link { Faker::Internet.url(scheme: 'https') }
    distance { Faker::Number.positive }
    text { Faker::Lorem.sentence }
    association :user
  end
end
