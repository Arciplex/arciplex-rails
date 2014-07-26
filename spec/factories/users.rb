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

    after(:build) { |user| user.class.skip_callback(:create, :before, :generate_temp_password) }

    after(:create) do |user|
      user.companies << create(:company)
    end
  end

  factory :admin_user, parent: :user do
    role "admin"
  end
end
