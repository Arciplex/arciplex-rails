require 'spec_helper'
include IntegrationHelper

feature "User Signs In" do

  let(:user) { create(:user, role: "requestor") }
  let(:admin_user) { create(:admin_user) }

  before :each do
    user
    admin_user
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

  scenario "with admin account", broken: true do
    # sign_in_with admin_user.email, 'password'
    # expect(page).to have_content("Admin Dashboard")
  end

  scenario "with account tied to many companies" do
    user.companies << create(:company)

    sign_in_with user.email, 'password'
    expect(page).to have_content("Select a company below")
    expect(page).to_not have_content("Admin Dashboard")
  end

end
