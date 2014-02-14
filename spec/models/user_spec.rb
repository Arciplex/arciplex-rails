require 'spec_helper'

describe User do
  let(:company) { create(:company) }
  let(:user) { build(:user) }
  
  before do
    company
    user.company_id = company.id
  end
  
  describe "#instance_methods" do
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
    
    describe "#has_role?" do
      context "when user has admin role" do
        it "should return true" do
          user.role = User::ROLES[1]
          user.save
          user.has_role?(:admin).should be_true
        end
      end
      
      context "when user does not have specified role" do
        it "should return false" do
          user.role = User::ROLES.last
          user.save
          user.has_role?(:superadmin).should be_false
        end
      end
    end
  end
  
end