FactoryBot.define do
  factory :item do
    association :user
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    category_id { Faker::Number.between(from: 2, to: 11) }
    condition_id { Faker::Number.between(from: 2, to: 7) }
    shipping_fee_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    days_to_ship_id { Faker::Number.between(from: 2, to: 4) }

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/AdobeStock_482730746.jpeg'), filename: 'AdobeStock_482730746.jpeg')
    end
  end
end
