FactoryGirl.define do
  factory :order do
    restaurant Faker::Name.name
    status "active"
    association :user, factory: :user
  end
end
