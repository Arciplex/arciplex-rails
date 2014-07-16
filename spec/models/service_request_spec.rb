require 'spec_helper'

describe ServiceRequest do

  let(:user) { create(:user) }
  let(:sr) { create(:service_request) }

  before do
    user
    sr
    user.service_requests << sr
  end

  describe "states" do
    describe ":pending" do
      it "should be initial state" do
        expect(sr.case_number).to be_present
        expect(sr).to be_pending
      end

      it "should change :pending to :opened" do
        sr.received!
        expect(sr).to be_opened
      end

      it "should change from :pending to :opened to :closed" do
        sr.received!
        sr.complete!
        expect(sr).to be_closed
      end

    end

  end

end
