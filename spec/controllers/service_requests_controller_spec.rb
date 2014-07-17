require 'spec_helper'
require 'will_paginate/array'

describe ServiceRequestsController, type: :controller do

  let(:user) { create(:user) }
  let(:service_request) { create(:service_request) }

  before :each do
    user
    service_request
    @company = user.companies.first
    @company.service_requests << service_request

    service_request.set_creation_fields(user.id, source: "User")
    service_request.save

    sign_in :user, user
    expect(controller).to receive(:get_company)
    controller.instance_variable_set(:@company, @company)
  end

  describe "GET index" do

    it "assigns all service requests as @service_requests" do
      get :index, {company_id: @company.id }
      expect(assigns(:service_requests).paginate(per_page: 10, page: nil)).to eq([service_request])
    end

    it "assigns service requests as @service_requests with opened status" do
      service_request.update_attribute(:status, "opened")
      get :index, {company_id: @company.id, status: "opened"}
      expect(assigns(:service_requests).paginate(per_page: 10, page: nil)).to eq([service_request])
    end

  end

  describe "GET show" do

    it "assigns service_request as @service_request" do
      get :show, { company_id: @company.id, id: service_request.id }
      expect(assigns(:service_request)).to eq service_request
    end

    it "returns 404 when service_request is not found" do
      get :show, { company_id: @company.id, id: "foo" }
      expect(response).to redirect_to company_service_requests_path(company_id: @company.id)
    end

  end

end
