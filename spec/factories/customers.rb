FactoryGirl.define do

  sequence(:contact_email) do |n|
    "user#{n}@lvh.me"
  end

  factory :customer do
    prefix "Mr"
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    contact_email
    phone_number "234-555-6565"

    after(:create) do |cust, elevator|
      create(:shipping_information, customer: cust)
    end
  end
end
