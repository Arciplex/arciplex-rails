require 'spec_helper'

describe ServiceRequest do

  let(:user) { create(:user) }
  let(:sr) { create(:service_request) }

  before do
    user
    sr

    sr.set_creation_fields(user.id, source: "User")
    sr.save
  end

  describe "states" do
    describe ":pre_approved" do
      it "should be initial state for SRs submitted via API" do
        expect(sr.case_number).to be_present
        expect(sr).to be_approved
      end

      it "should change :pre_approved to :pending" do
        sr.approved!
        expect(sr).to be_pending
      end
    end

    describe ":pending" do
      it "should be initial state if submitted via backoffice" do
        sr.approved!
        expect(sr.case_number).to be_present
        expect(sr).to be_pending
      end

      it "should change :pending to :opened" do
        sr.approved!
        sr.received!
        expect(sr).to be_opened
      end

      it "should change from :pending to :opened to :closed" do
        sr.approved!
        sr.received!
        sr.complete!
        expect(sr).to be_closed
      end

    end

  end

  describe "#set_creation_fields" do
    it "should set creation_source and creation_identifier" do
      sr = create(:service_request)
      sr.set_creation_fields(user.id, source: "User")
      sr.save

      expect(sr.creation_source).to eql("User")
      expect(sr.creation_identifier).to eql(user.id)
    end
  end

  describe "#api_created?" do
    it "should return true if creation_source is API" do
      sr = create(:service_request)
      sr.set_creation_fields("ABC123", source: "API")
      sr.save

      expect(sr.api_created?).to be_truthy
    end

    it "should return false if creation_source is User" do
      expect(sr.api_created?).to be_falsey
    end
  end

  describe "#creator" do
    it "should return user full name" do
      expect(sr.creator).to eql(user.full_name)
    end

    it "should return null if API created" do
      sr = create(:service_request)
      sr.set_creation_fields("ABC123", source: "API")
      sr.save

      expect(sr.creator).to be_nil
    end
  end

end
