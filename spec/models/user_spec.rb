require 'spec_helper'

describe User do
  let(:company) { create(:company) }
  let(:user) { build(:user) }
  
  before do
    company
    user.company_id = company.id
  end
  
  describe "#create" do
    context "when normal user is created" do
      it "should set .role to requestor" do
        user.save
        user.role.should eq User::ROLES.last
      end
    end
    
    context "when admin user is created" do
      it "should set .role to admin" do
        user.role = User::ROLES[1]
        user.save
        user.role.should eq User::ROLES[1]
      end
    end
  end
end