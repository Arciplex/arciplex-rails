FactoryGirl.define do
  factory :customer do
    prefix "Mr"
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
  end
end