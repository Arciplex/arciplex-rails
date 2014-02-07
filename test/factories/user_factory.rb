FactoryGirl.define do
  sequence :email do |n|
    "person#{n}@example.com"
  end
  
  factory :user do
    email
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    company
  end
end