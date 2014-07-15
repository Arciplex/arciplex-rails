require 'spec_helper'

describe User do
  let(:user) { create(:user) }

  before do
    user
  end

  describe "#instance_methods" do
    describe "#has_role?" do
      context "when user has admin role" do
        it "should return true" do
          user.role = "admin"
          user.save
          expect(user.has_role?(:admin)).to be_truthy
        end
      end

      context "when user does not have specified role" do
        it "should return false" do
          user.role = "support_vendor"
          user.save
          expect(user.has_role?(:foo)).to be_falsey
        end
      end
    end
  end

end
