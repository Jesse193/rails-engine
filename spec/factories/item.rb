FactoryBot.define do
  factory :item do
    name { Faker::Device.model_name}
    description {Faker::Lorem.sentence}
    unit_price {Faker::Number.number(digits: 4)}
    merchant
  end
end