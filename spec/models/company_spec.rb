require 'spec_helper'

describe Company do

  let(:company) { create(:company) }

  before do
    company.api_keys << create(:api_key)
  end

  describe "#can_report_rma?" do
    it "should return true" do
      company.update_attribute(:name, "Elan")
      expect(company.can_report_rma?).to be_truthy
    end

    it "should return true" do
      expect(company.can_report_rma?).to be_falsey
    end
  end

  describe "#clients_can_receive_notitifications?" do
    it "should return false" do
      company.update_attribute(:name, "Elan")
      expect(company.clients_can_receive_notitifications?).to be_falsey
    end

    it "should return true" do
      expect(company.clients_can_receive_notitifications?).to be_truthy
    end
  end

  describe "#can_make_orders?" do
    it "should return true" do
      expect(company.can_make_orders?).to be_truthy
    end

    it "should return false" do
      company.update_attribute(:can_manage_orders, false)
      expect(company.can_make_orders?).to be_falsey
    end
  end

end
