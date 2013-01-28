FactoryGirl.define do
  factory :post do
    body  { Faker::Lorem.sentence  }
    title { Faker::Lorem.paragraph }
    user
  end
end
