FactoryBot.define do
  factory :post_address do
    map_link { Faker::Internet.url(scheme: 'https') }
    postal_code { 6_580_084 }
    prefecture_code { '兵庫県' }
    city { '神戸市東灘区' }
    street { '甲南町' }
    distance { Faker::Number.positive }
    course { 'どちらともいえない' }
    slope { 'どちらともいえない' }
    traffic { 'どちらともいえない' }
    crowd { 'どちらともいえない' }
    view { 'まあまあ' }
    comment { Faker::Lorem.sentence }
    user_id { 1 }

    # after(:build) do |post_address|
    #   post_address.image.attach(io: File.open('public/images/noimage.png'), filename: 'noimage.png')
    # end
  end
end
