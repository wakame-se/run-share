FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.free_email }
    password = '1a' + Faker::Internet.password(min_length: 6)
    password { password }
    password_confirmation { password }
    gimei = Gimei.name
    last_name { gimei.last }
    first_name { gimei.first }
    last_name_reading { gimei.last.katakana }
    first_name_reading { gimei.first.katakana }
    birthday { Faker::Date.between(from: '1930-01-01', to: Date.today) }
  end
end
