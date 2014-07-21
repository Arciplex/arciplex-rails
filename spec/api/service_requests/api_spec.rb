require 'spec_helper'

describe ServiceRequests::API do
  describe "GET /api/v1/service_requests" do

    let(:company) { create(:company) }
    let(:api_key) { create(:api_key) }
    let(:service_request) { create(:service_request) }

    context "ping" do
      it "should return alive status" do
        get "/api/v1/ping"

        expect(response.status).to eql 200
        expect(JSON.parse(response.body)).to have_key('message')
        expect(JSON.parse(response.body)['message']).to eq "I'm Alive"
      end
    end

    context "valid token" do

      before(:each) do
        company
        company.api_keys << api_key
        @token = api_key.access_token
      end

      it "returns an empty array of service_requests" do
        get "/api/v1/service_requests?token=#{@token}"
        expect(response.status).to eql 200
        expect(JSON.parse(response.body)).to eql []
      end

      it "returns an array of service_requests" do
        company.service_requests << service_request

        get "/api/v1/service_requests?token=#{@token}"

        expect(response.status).to eql 200
        expect(response.body).to eql [service_request].to_json
      end

    end

    context "invalid token" do

      before(:each) do
        company
        company.api_keys << api_key
      end

      it "returns a 401 response" do
        get "/api/v1/service_requests?token=1234"

        expect(response.status).to eql 401
        expect(JSON.parse(response.body)).to have_key('error')
        expect(JSON.parse(response.body)['error'])
          .to eq "Unauthorized. Invalid token"
      end

    end

  end
end
