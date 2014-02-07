require 'spec_helper'

describe User do
  let(:company) { create(:company) }
  
  before do
    company
  end
  
  describe "#create" do
    context "when normal user is created" do
      it "should set .role to requestor" do
        user = create(:user)
        user.company_id = company.id
        user.save
        user.role.should eq "requestor"
      end
    end
  end
end