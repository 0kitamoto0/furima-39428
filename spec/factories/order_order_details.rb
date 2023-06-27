FactoryBot.define do
  factory :order_order_detail do
    token { 'tok_abcdefghijk00000000000000000' }
    postal_code { '123-4567' }
    prefecture_id { Faker::Number.between(from: 2, to: 47) }
    phone_number { Faker::Number.unique.number(digits: Faker::Number.between(from: 10, to: 11)) }
    city { Faker::Address.city }
    street_address { Faker::Address.street_address }
    building_name { Faker::Address.building_number }
  end
end
