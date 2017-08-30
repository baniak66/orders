FactoryGirl.define do
  factory :meal do
    name Faker::Name.name
    price Faker::Number.number(2)
    association :order, factory: :order
    association :user, factory: :user
  end
end
