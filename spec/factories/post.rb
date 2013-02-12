FactoryGirl.define do
  factory :post do
    body  { Faker::Lorem.sentence(2) }
    title { Faker::Lorem.paragraph   }
    user
  end
end
