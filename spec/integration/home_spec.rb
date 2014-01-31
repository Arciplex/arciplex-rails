require 'spec_helper'

feature 'User visits home page' do
  
  scenario 'displays login screen' do
    visit root_path
    expect(page).to have_content "Please, sign into your account"
  end
  
end