require 'spec_helper'

feature "User Signs In" do

  let(:user) { create(:user, role: "requestor") }

  before(:each) do
    user
  end

  scenario "with invalid email or password" do
    # TODO: Try to figure out how to test JS growl popup notification
    sign_in_with user.email, ''
    expect(page).to have_content('Please, sign into your account')
  end

  scenario "with valid email and password" do
    sign_in_with user.email, 'password'
    expect(page).to have_content('Service Requests')
  end

  scenario "with admin account" do
    user.role = "admin"
    user.save

    sign_in_with user.email, 'password'
    expect(page).to have_content("Admin Dashboard")
  end

  scenario "with account tied to many companies" do
    user.companies << create(:company)

    sign_in_with user.email, 'password'
    expect(page).to have_content("Select a company below")
  end

end

def sign_in_with(email, password)
  visit root_path
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_button 'Sign in'
end
