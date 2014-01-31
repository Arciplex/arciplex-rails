require 'spec_helper'

feature "User Signs In" do
  
  let(:user) { create(:user) }
  
  before(:each) do
    user
  end
  
  scenario "with invalid email and password" do
    sign_in_with "foo1@bar.com", "password"
    expect(page).to have_content('Invalid email or password')
  end
  
  scenario "with valid email and password" do
    sign_in_with user.email, 'password'
    expect(page).to have_content('Service Request')
  end
end

def sign_in_with(email, password)
  visit root_path
  fill_in 'Email Address', with: email
  fill_in 'Password', with: password
  click_button 'Sign in'
end