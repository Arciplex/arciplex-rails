FactoryGirl.define do
  factory :company do
    name Faker::Company.name
    can_manage_orders true
  end
end
