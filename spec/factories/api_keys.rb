FactoryGirl.define do
  factory :api_key do
    access_token "12345"
    company
    active true
  end
end
