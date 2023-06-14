FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6, mix_case: true, special_characters: false) }
    password_confirmation { password }
    last_name { Faker::Japanese::Name.last_name.tr('A-Za-z', 'ア-ン') }
    first_name { Faker::Japanese::Name.first_name }
    last_name_kana { Faker::Japanese::Name.last_name.yomi }
    first_name_kana { Faker::Japanese::Name.first_name.yomi }
    date_of_birth { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
