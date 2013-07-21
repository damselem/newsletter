FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.sentence(2) }
    body { Faker::Lorem.paragraph }
    user
  end
end
