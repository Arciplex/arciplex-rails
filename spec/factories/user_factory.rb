FactoryGirl.define do
  sequence(:email) do |n|
    "user#{n}@lvh.me"
  end
  
  factory :user do
    email
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password "password"
    password_confirmation "password"
    company
  end
end
