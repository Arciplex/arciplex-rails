require 'spec_helper'
include IntegrationHelper

feature "User Signs In and navigates to Company Service Request Dashboard" do

  let(:user) { create(:user) }
  let(:service_request) { create(:service_request) }
  let(:customer) { create(:customer) }

  before do
    user
    customer
    service_request
    @company = user.companies.first

    service_request.update_attributes(user_id: user.id, company_id: @company.id, customer_id: customer.id)

    sign_in_with user.email, 'password'
  end

  after do
    @company = nil
  end

  scenario "sign in, navigate to ServiceController#index" do
    expect(page).to have_content("Service Requests")
    expect(page).to have_content("Create New Service Request")
    expect(current_path).to eq company_service_requests_path(company_id: @company.id)
  end

  scenario "click create new SR button, navigate to ServiceRequestsController#new" do
    click_link "Create New Service Request"
    expect(page).to have_content("New Service Request")
    expect(current_path).to eq new_company_service_request_path(company_id: @company.id)
  end

  scenario "user fills out new SR form with required information" do
    click_link "Create New Service Request"

    fill_out_sr_form

    sr = ServiceRequest.first

    expect(page).to have_content("Viewing Service Request")
    expect(current_path).to eq company_service_request_path(company_id: @company.id, id: sr.id)
  end

  scenario "user fills out new SR form without required info" do
    click_link "Create New Service Request"

    fill_out_sr_form(product_concern: false)

    expect(page).to have_content("Product Concern can't be blank")
    expect(current_path).to eq company_service_requests_path(company_id: @company.id)
  end

  scenario "user clicks to view a SR" do
    within "#service-requests-table" do
      first(:link, "View").click
    end

    expect(page).to have_content("Viewing Service Request")
    expect(current_path).to eq company_service_request_path(company_id: @company.id, id: service_request.id)
  end

end
