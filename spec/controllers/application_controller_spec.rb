require 'spec_helper'

describe ApplicationController, type: :controller do
  controller do
    def after_sign_in_path_for(resource)
      super resource
    end
  end

  let(:user) { create(:user) }
  let(:admin_user) { create(:admin_user) }

  before :each do
    user
    admin_user
  end

  describe "After sign-in" do
    it "redirects to /admin" do
      expect(controller.after_sign_in_path_for(admin_user)).to eq admin_path
    end

    it "redirects to company_service_requests_path" do
      expect(controller.after_sign_in_path_for(user))
      .to eq company_service_requests_path(company_id: user.companies.first.id)
    end

    it "redirects to multiple company select page" do
      user.companies << create(:company)
      expect(controller.after_sign_in_path_for(user)).to eq admin_path
    end
  end

end
