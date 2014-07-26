require 'spec_helper'
include IntegrationHelper

feature "Searching for ServiceRequests" do

  let(:user) { create(:user) }
  let(:service_request) { create(:service_request) }
  let(:customer) { create(:customer) }

  before do
    user
    service_request
    customer

    @company = user.companies.first

    service_request.update_attributes(
      company_id: @company.id,
      customer_id: customer.id,
      creation_source: "User",
      creation_identifier: user.id
    )

    sign_in_with user.email, 'password'
  end

  after do
    @company = nil
  end

  scenario "User searches but no results found" do
    within '#search-form' do
      fill_in "Search Service Requests", with: 'foobaz'
      click_button "Submit"
    end

    expect(page).to have_content "No Results Found"
  end

  scenario "User searches for SR by case number" do

    within '#search-form' do
      fill_in "Search Service Requests", with: service_request.id
      click_button "Submit"
    end

    expect(page).to have_content(service_request.id)
  end

  scenario "User searches for SR by full name" do

    within '#search-form' do
      fill_in "Search Service Requests", with: service_request.customer.full_name
      click_button "Submit"
    end

    expect(page).to have_content(service_request.customer.first_name)
  end

  scenario "User searches for SR by serial number" do

    within '#search-form' do
      fill_in "Search Service Requests",
        with: service_request.line_items.first.serial_number
      click_button "Submit"
    end

    expect(page).to have_content(service_request.id)
  end

end
