FactoryGirl.define do
  factory :user do
    provider "facebook"
    uid {Faker::Number.number(7)}
    name {Faker::Name.name}
    image_url {Faker::LoremPixel.image("50x50")}
    url {Faker::Internet.url}
  end
end
