FactoryBot.define do
  factory :post do
    map_link { Faker::Internet.url(scheme: 'https') }
    distance { Faker::Number.positive }
    course { 'どちらともいえない' }
    slope { 'どちらともいえない' }
    traffic { 'どちらともいえない' }
    crowd { 'どちらともいえない' }
    view { 'まあまあ' }
    comment { Faker::Lorem.sentence }
    association :user
  end
end
