require 'spec_helper'

describe Customer do
  
  let(:company) { create(:company) }
  let(:user) { create(:user, company: company) }
  let(:customer) { create(:customer, user_id: user.id, company_id: user.company.id) }
  let(:shipping_information) { create(:shipping_information, customer_id: customer.id) }
  
  describe "#instance_methods" do
    
    before do
      company
      user
      customer
      shipping_information
    end
    
    describe "#full_name" do
      
      context "when first_name is set" do
        it "returns only first_name" do
          customer.stub(:last_name).and_return(nil)
          customer.full_name.should eq customer.first_name
        end
      end
      
      context "when last_name is set" do
        it "returns only last_name" do
          customer.stub(:first_name).and_return nil
          customer.full_name.should eq customer.last_name
        end
      end
      
      context "when first & last name is set" do
        it "returns combined full name" do
          customer.full_name.should eq "#{customer.first_name} #{customer.last_name}"
        end
      end
      
    end
  end
end