FactoryGirl.define do
  factory :shipping_information do
    address Faker::Address.street_address
    address2 Faker::Address.secondary_address
    city Faker::Address.city
    state "GA"
    zip_code Faker::Address.zip_code
    country "USA"
    address_type "Residential"
  end
end