FactoryGirl.define do
  sequence(:uid) {|n| n }

  factory :user do
    email      { Faker::Internet.email  }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name  }
    provider   'google_oauth2'
    uid        { generate(:uid) }
  end

end
